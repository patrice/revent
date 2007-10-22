class Admin::Events2Controller < AdminController 

	active_scaffold :events do |config|
  		config.columns = [:name, :start, :end, :short_description, :description, :city, :state, :postal_code, :directions, :max_attendees, :private, :location, :category, :taggings, :call_script, :letter_script, :district, :campaign_key, :person_legislator_ids, :latitude, :longitude]
  		columns[:category].ui_type = :select
		#config.columns[:state].ui_form = :usa_state 
  		config.list.columns = [:start, :name, :city, :state, :host, :tags, :category, :calendar]
  		config.list.sorting = [{ :name => :asc}]
		#config.action_links.add '/profile/events', :label => 'Manage', :type => :record, :page => true
  end
  
end
