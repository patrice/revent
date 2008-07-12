class Report < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  acts_as_list :scope => :event_id
  has_many :attachments, :dependent => :destroy
  has_many :embeds, :dependent => :destroy
  has_many :press_links, :dependent => :destroy

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
  validates_associated :attachments, :press_links, :user

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
  
  def check_akismet(request)
    akismet = Akismet.new '8ec4905c5374', 'http://events.stepitup2007.org'
    unless akismet.comment_check(:user_ip => request[:remote_ip],
                             :user_agent => request[:user_agent],
                             :referrer => request[:referer],
                             :comment_author => reporter_name,
                             :comment_author_email => reporter_email,
                             :comment_content => text)
      self.publish
    end
    akismet.last_response
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

  attr_accessor :press_link_data
  before_save :build_press_links
  def build_press_links
    self.press_links.build(press_link_data) if press_link_data
  end

  def reporter_data=(attributes)
    self.user = User.find_or_initialize_by_site_id_and_email( Site.current.id, attributes[:email] )
    self.user.attributes = attributes
    self.user.random_password
    self.user.save!
  end

  attr_accessor :attachment_data
  before_save :build_attachments
  def build_attachments
    self.attachments.build(attachment_data.values) if attachment_data
  end
end
