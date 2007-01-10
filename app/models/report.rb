class Report < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  acts_as_list :scope => :event
  has_many :attachments, :dependent => :destroy
  def before_create
    self.status = Report::PUBLISHED
  end

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
    with_scope :find => { :conditions => [ 'status = ?', PUBLISHED ] } do
      find(*args)
    end
   end
  def self.count_published(*args)
    with_scope :find => { :conditions => [ 'status = ?', PUBLISHED ] } do
      count(*args)
    end
    
  end
  def find_published(*args)
    self.find_published(id, *args)
  end
end
