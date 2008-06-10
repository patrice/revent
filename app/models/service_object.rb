class ServiceObject < ActiveRecord::Base
  belongs_to :mirrored, :polymorphic => true
  validates_presence_of :remote_service
end
