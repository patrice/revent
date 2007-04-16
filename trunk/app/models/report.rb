class Report < ActiveRecord::Base
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

  validates_presence_of :event_id, :reporter_name, :reporter_email, :text
  validates_format_of :reporter_email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :create
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
end
