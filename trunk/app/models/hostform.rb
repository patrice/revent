class Hostform < ActiveRecord::Base
	belongs_to :calendar
	belongs_to :site
	has_one :trigger
	
  validates_format_of :tag, :with => /^[a-zA-Z0-9\_\-]+$/, :message => "can not contain special characters"
end
