class Report < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  acts_as_list :scope => :event_id

  has_many :attachments, :dependent => :destroy
  has_many :embeds, :dependent => :destroy
  has_many :press_links, :dependent => :destroy
#  validates_associated :attachments, :press_links, :embeds, :user

  after_create :trigger_email  
  def trigger_email
    calendar = self.event.calendar
    if calendar.report_dia_trigger_key.blank?
      if calendar.triggers.any?
        trigger = calendar.triggers.find_by_name("Report Thank You") || Site.current.triggers.find_by_name("Report Thank You")
        require 'ostruct'
        reporter = OpenStruct.new(:name => self.reporter_name, :email => self.reporter_email)
        TriggerMailer.deliver_trigger(trigger, reporter, self.event) if trigger
      end
    end
  end

  has_one :salesforce_object, :as => :mirrored, :class_name => 'ServiceObject', :dependent => :destroy
  after_save :sync_to_salesforce
  def sync_to_salesforce
    return true unless Site.current.salesforce_enabled?
    SalesforceWorker.async_save_participant(:report_id => self.id)
  rescue Workling::WorklingError
    logger.error("SalesforceWorker.async_save_participant(:report_id => #{self.id}) failed! Perhaps workling is not running. Got Exception: #{e}")
  ensure
    return true # don't kill the callback chain since it may still do something useful
  end

  before_destroy :delete_from_salesforce
  def delete_from_salesforce
    return true unless self.event.calendar.site.salesforce_enabled? && self.salesforce_object
    SalesforceWorker.async_delete_participant(self.salesforce_object.remote_id)
  rescue Workling::WorklingError
    logger.error("SalesforceWorker.async_delete_participant(:report_id => #{self.id}) failed! Perhaps workling is not running. Got Exception: #{e}")
  ensure
    return true # don't kill the callback chain since it may still do something useful
  end
    
  def primary!
    self.move_to_top
  end

  def primary?
    self.first?
  end

  validates_presence_of :event_id, :text

  PUBLISHED = 'published'
  UNPUBLISHED = 'unpublished'

  def published?
    PUBLISHED == status
  end

  def self.publish(id)
    update(id, :status => PUBLISHED)
  end

  def self.unpublish(id)
    update(id, :status => UNPUBLISHED)
  end

  def publish
    update_attribute(:status, PUBLISHED)
  end

  def unpublish
    update_attribute(:status, UNPUBLISHED)
  end

  def self.find_published(*args)
    with_scope :find => { :conditions => [ 'reports.status = ?', PUBLISHED ] } do
      find(*args)
    end
  end
  def self.paginate_published(*args)
    with_scope :find => { :conditions => [ 'reports.status = ?', PUBLISHED ] } do
      paginate(*args)
    end
  end
  def self.count_all_published(*args)
    with_scope :find => { :conditions => [ 'reports.status = ?', PUBLISHED ] } do
      count(*args)
    end
  end
  def self.count_published(*args)
    count_by_sql("SELECT COUNT(DISTINCT event_id) FROM reports WHERE reports.status = '#{PUBLISHED}'")
  end
  def find_published(*args)
    self.find_published(id, *args)
  end
  

  def reporter_name
    user ? user.full_name : read_attribute('reporter_name')
  end

  def reporter_first_name
    user ? user.first_name : read_attribute('reporter_name').split(' ')[0]
  end

  def reporter_email
    user ? user.email : read_attribute('email')
  end

  before_save :build_press_links, :build_attachments, :build_embeds, 
              :check_akismet, :send_attachments_to_flickr

  attr_accessor :press_link_data
  def build_press_links
    return true unless press_link_data
    links = press_link_data.values.select {|p| !p[:url].blank?}
    self.press_links.build(links) if links.any?
    #self.press_links.build(press_link_data.values) if press_link_data
    true
  end

  attr_accessor :attachment_data
  def build_attachments
    return true unless attachment_data
    attaches = attachment_data.values.select{ |att| !att[:uploaded_data].blank? }
    self.attachments.build(attaches) if attaches.any?
    true
  end

  attr_accessor :embed_data
  def build_embeds
    return true unless embed_data
    embeddables = embed_data.values.select{ |emb| !emb[:html].blank? }
    self.embeds.build(embeddables) if embeddables.any?
    true
  end

  def reporter_data=(attributes)
    self.user = User.find_or_initialize_by_site_id_and_email( Site.current.id, attributes[:email] )
    self.user.attributes = attributes
    self.user.random_password
    self.user.save!
  end

  attr_accessor :akismet_params
  def akismet_params
    @akismet_params ||= {} 
  end
  def akismet_params=( request )
    @akismet_params = { 
      :user_ip => request.remote_ip,
      :user_agent => request.user_agent,
      :referrer => request.referer 
    }
  end
  def check_akismet
    return true if self.published?
    akismet = Akismet.new '8ec4905c5374', 'http://events.stepitup2007.org'

    if !akismet.comment_check( 
        akismet_params.merge({ 
          :comment_author => reporter_name,   
          :comment_author_email => reporter_email, 
          :comment_content => text })
        ) || ( RAILS_ENV == 'development' )
      self.status = PUBLISHED
    end
    # use akismet.last_response to get result
    true
  end

  def flickr_title
    "#{event.name} - #{event.city}, #{event.state}"
  end

  def send_attachments_to_flickr
    return true unless Site.flickr and self.published?
    self.attachments.each do |att|
      next if att.flickr_id # maybe also verify that its an image???
      begin
        att.flickr_id = Site.flickr.photos.upload.upload_image(att.temp_data, att.content_type, att.filename, flickr_title, att.caption, event.calendar.flickr_tags)
        if event.calendar.flickr_photoset and att.flickr_id and att.primary?
          photoset_result = Site.flickr.photosets.addPhoto(event.calendar.flickr_photoset, att.flickr_id)
        end
        logger.info(att.flickr_id ? "FLICKR photo #{att.flickr_id} saved" : "FLICKR could not save photo #{flickr_title} to flickr")
      rescue XMLRPC::FaultException
        logger.error("FLICKR XMLRPC::Exception occurred while trying to upload #{flickr_title}.")
      end
    end
    true
  end
end
