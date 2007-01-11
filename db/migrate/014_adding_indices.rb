class AddingIndices < ActiveRecord::Migration
  def self.up
    add_index :reports, :event_id
    add_index :attachments, :report_id
    add_index :reports, [:status, :position]
    add_index :events, [:latitude, :longitude]
    add_index :events, :postal_code
    add_index :events, [:state, :city]
    add_index :reports, :status
  end

  def self.down
    remove_index :reports, :event_id
    remove_index :attachments, :report_id
    remove_index :reports, [:status, :position]
    remove_index :events, [:latitude, :longitude]
    remove_index :events, :postal_code
    remove_index :events, [:state, :city]
    remove_index :reports, :status
  end
end
