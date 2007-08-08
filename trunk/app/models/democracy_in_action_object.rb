class DemocracyInActionObject < ActiveRecord::Base
  belongs_to :synced, :polymorphic => true
  before_save :set_table
  def set_table
    self.table ||=  synced.democracy_in_action_synced_table if synced.respond_to?(:democracy_in_action_synced_table)
    self.table ||= synced.class.downcase
  end
end
