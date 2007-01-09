class Report < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  acts_as_list :scope => :event
  has_many :attachments

  PUBLISHED = 'published'
  UNPUBLISHED = 'unpublished'

  def published?
    PUBLISHED == status
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
end
