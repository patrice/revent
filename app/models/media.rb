class Media < ActiveRecord::Base
  acts_as_attachment :storage => :file_system
  belongs_to :user
  belongs_to :report
end
