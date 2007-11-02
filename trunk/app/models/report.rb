class Report < ActiveRecord::Base
  @@flickr = []

  belongs_to :event
  belongs_to :user
  acts_as_list :scope => :event_id
  has_many :attachments, :dependent => :destroy
  has_many :press_links, :dependent => :destroy
  def before_create
    self.status = Report::PUBLISHED
  end

  def primary!
    self.move_to_top
  end

  def primary?
    self.first?
  end

  validates_presence_of :event_id, :text
  validates_associated :attachments

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

  def upload_images_to_flickr
    attachments.each do |attachment|
      begin
        data = attachment.temp_data
        data ||= File.read(attachment.full_filename) if File.exists?(attachment.full_filename)
        data ||= open(attachment.public_filename).read
        flickr.photos.upload.upload_image_async(data, attachment.content_type, "#{event.name} - #{event.city}, #{event.state}", attachment.caption, ["stepitup", "stepitup#{event_id}"])
      rescue XMLRPC::FaultException
      end
    end
  end

  def flickr
    site_id = Site.current.id
    @@flickr[site_id] ||= {}
    @@flickr[site_id][:config] ||= YAML.load_file(File.join(RAILS_ROOT,'sites',site_id.to_s,'config','flickr',RAILS_ENV,'flickr.yml'))
    @@flickr[site_id][:api] ||= Flickr.new(File.join(RAILS_ROOT,'sites',site_id.to_s,'config','flickr',RAILS_ENV,'token.cache'), @@flickr[site_id][:config]['api_key'], @@flickr[site_id][:config]['shared_secret'])
  end

  def check_akismet(request)
    akismet = Akismet.new '8ec4905c5374', 'http://events.stepitup2007.org'
    if akismet.comment_check(:user_ip => request[:remote_ip],
                             :user_agent => request[:user_agent],
                             :referrer => request[:referer],
                             :comment_author => reporter_name,
                             :comment_author_email => reporter_email,
                             :comment_content => text)

      self.publish
    end
  end

  def reporter_name
    user ? user.full_name : read_attribute('reporter_name')
  end

  def reporter_email
    user ? user.email : read_attribute('email')
  end
end
