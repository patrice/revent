class Trigger < ActiveRecord::Base
	belongs_to :calendar
	belongs_to :site
end
