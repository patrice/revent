class Report < ActiveRecord::Base
  belongs_to :event
  acts_as_list :scope => :event
end
