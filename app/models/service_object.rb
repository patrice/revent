class ServiceObject < ActiveRecord::Base
  belongs_to :pushable, :polymorphic => true
  validates_presence_of :service_name
end
