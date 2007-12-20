class Trigger < ActiveRecord::Base
	belongs_to :calendar
	belongs_to :site
	belongs_to :type, :class_name => "TriggerType", :foreign_key => "type_id"	

	validates_presence_of     :from, :email_text, :type_id, :site_id
	validates_uniqueness_of   :type_id, :scope => [:site_id, :calendar_id]
  validates_length_of       :from, :within => 3..100
end
