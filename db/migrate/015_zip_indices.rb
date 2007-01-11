class ZipIndices < ActiveRecord::Migration
  def self.up
    change_column :zip_codes, :latitude, :float, :precision => 10, :scale => 6
    change_column :zip_codes, :longitude, :float, :precision => 10, :scale => 6
    add_index :zip_codes, :zip
    add_index :zip_codes, :latitude
    add_index :zip_codes, :longitude
    add_index :zip_codes, [:latitude, :longitude]
  end

  def self.down
    change_column :zip_codes, :latitude, :string
    change_column :zip_codes, :longitude, :string
    remove_index :zip_codes, :zip
    remove_index :zip_codes, :latitude
    remove_index :zip_codes, :longitude
    remove_index :zip_codes, [:latitude, :longitude]
  end
end
