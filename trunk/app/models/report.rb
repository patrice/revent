class Report < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  acts_as_list :scope => :event_id
  has_many :attachments, :dependent => :destroy
  has_many :embeds, :dependent => :destroy
  has_many :press_links, :dependent => :destroy

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

  def reporter_email
    user ? user.email : read_attribute('email')
  end
end
