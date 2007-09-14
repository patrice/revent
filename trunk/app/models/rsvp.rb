class Rsvp < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  belongs_to :attending, :polymorphic => true

=begin
  has_one :democracy_in_action_object, :as => :synced
  def democracy_in_action_synced_table
    'supporter_event'
  end
  after_save :sync_to_democracy_in_action
  def sync_to_democracy_in_action
    return unless self.user.democracy_in_action_key && self.event.democracy_in_action_key
    require 'democracyinaction'
    api = DemocracyInAction::API.new API_OPTS

    key = api.process democracy_in_action_synced_table, 'supporter_KEY' => self.user.democracy_in_action_key, 'event_KEY' => self.event.democracy_in_action_key, '_Status' => 'Signed Up', '_Type' => 'Supporter'
    self.create_democracy_in_action_object :key => key, :table => democracy_in_action_synced_table unless self.democracy_in_action_object
  end
=end
end
