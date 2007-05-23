class AddDistrictsAndLegislators < ActiveRecord::Migration
  def self.up
    File.open(File.dirname(__FILE__) + '/districts_and_legislators.sql', 'r') do |file|
      file.each do |line|
        execute line
      end
    end
  end

  def self.down
  end
end
