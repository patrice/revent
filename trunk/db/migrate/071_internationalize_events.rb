class InternationalizeEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :country_code, :integer, :default => 840   # default to United States (840)
    add_column :users, :country_code, :integer

=begin    
    Event.find(:all).each do |e|
      if DemocracyInAction::Helpers::state_options_for_select.include?(e.state) 
        e.country_code = 840  # USA_COUNTRY_CODE 
      elsif DemocracyInAction::Helpers::state_options_for_select(:include_provinces => true).include?(e.state)
        e.country_code = 124  # CANADA_COUNTRY_CODE 
      end
      e.save if e.country_code
    end
    
    User.find(:all).each do |u|
      if DemocracyInAction::Helpers::state_options_for_select.include?(u.state)
        u.country_code = 840  # USA_COUNTRY_CODE
      elsif DemocracyInAction::Helpers::state_options_for_select(:include_provinces => true).include?(u.state)
        u.country_code = 124  # CANADA_COUNTRY_CODE 
      end
      u.save if u.country_code
    end
=end
  end
  
  def self.down
    remove_column :events, :country_code
    remove_column :users, :country_code
  end
end
