class StoreSalesforceId < ActiveRecord::Migration
  def self.up
    create_table :service_objects do |t|
      t.integer :pushable_type
      t.integer :pushable_id
      t.string  :service_name
      t.integer :service_table
      t.integer :service_id
    end
  end

  def self.down
    drop_table :service_objects
  end
end
