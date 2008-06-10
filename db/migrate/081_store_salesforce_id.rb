class StoreSalesforceId < ActiveRecord::Migration
  def self.up
    create_table :service_objects do |t|
      t.integer :mirrored_type  # local type 
      t.integer :mirrored_id    # local id 
      t.string  :remote_service
      t.integer :remote_type
      t.integer :remote_id
    end
  end

  def self.down
    drop_table :service_objects
  end
end
