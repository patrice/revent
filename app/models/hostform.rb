class Hostform < ActiveRecord::Base
	belongs_to :calendar
	belongs_to :site
	has_one :trigger
	
  validates_format_of :tag, :with => /^[a-zA-Z0-9\_\-]+$/, :message => "can not contain special characters", :if => :tag_not_blank
  def tag_not_blank
    not self.tag.blank?
  end
end
