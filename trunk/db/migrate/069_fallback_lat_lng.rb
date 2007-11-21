class FallbackLatLng < ActiveRecord::Migration
  def self.up
    add_column :events, :fallback_latitude,  :float
    add_column :events, :fallback_longitude, :float

    puts 'Processing all events...'
    Event.find(:all).each do |e|
      # event gets re-geocoded on save
      puts '.'
      e.save unless e.latitude and e.longitude 
    end
  end
  
  def self.down
    remove_column :events, :fallback_latitude
    remove_column :events, :fallback_longitude
  end
end