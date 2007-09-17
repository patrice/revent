class PoliticianInvite < ActiveRecord::Base
  belongs_to :user
  belongs_to :politician
  belongs_to :event

  has_one :democracy_in_action_object, :as => :associated
end
