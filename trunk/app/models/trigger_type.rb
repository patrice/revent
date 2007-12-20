class TriggerType < ActiveRecord::Base
  has_many :triggers, :foreign_key => 'type_id'
end