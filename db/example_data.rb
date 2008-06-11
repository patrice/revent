module FixtureReplacement
  attributes_for :attachment do |a|
    
	end

  attributes_for :blog do |a|
    
	end

  attributes_for :calendar do |a|
    a.name = "Step It Up" 
    a.permalink = "stepitup"
    a.site = default_site
    a.theme = "stepitup"
    a.event_start = 5.years.ago
    a.event_end = 5.years.from_now
	end

  attributes_for :category do |a|
    
	end

  attributes_for :democracy_in_action_object do |a|
    
	end

  attributes_for :embed do |a|
    
	end

  cities = ["San Francisco", "New York", "Santa Fe", "Seattle", "Miami", "Los Angeles"]
  states = DemocracyInAction::Helpers.state_options_for_select

  attributes_for :event do |a|
    a.calendar = default_calendar
    a.host = default_user
    a.name = "Step It Up"
    a.location = "1 Market St."
    a.description = "This event will be awesome."
    a.city = cities[rand(cities.length)]
    a.state = states[rand(states.length)].last
    a.postal_code = "94114"
    a.start = Time.now + 2.months
    a.end = a.start + 2.hours
	end

=begin
  attributes_for :service_object do |a|
    a.mirrored = default_user
    a.remote_service = "Salesforce"
    a.remote_id = '555'
    a.remote_type = 'Contact'
  end
=end

  attributes_for :hostform do |a|
    
	end

  attributes_for :politician_invite do |a|
    
	end

  attributes_for :politician do |a|
    
	end

  attributes_for :press_link do |a|
    
	end

  attributes_for :report do |a|
    a.event = default_event
    a.user = default_user
	end

  attributes_for :role do |a|
    a.title = "admin"
	end

  attributes_for :rsvp do |a|
    
	end

  attributes_for :site do |a|
   a.host = "events." + String.random(10) + ".org"
   a.theme = "stepitup"
	end

  attributes_for :tagging do |a|
    
	end

  attributes_for :tag do |a|
    
	end

  attributes_for :trigger do |a|
    
	end

  attributes_for :user do |a|
    a.first_name = "Jon"
    a.last_name = "Warnow"
    a.phone = "555-555-5555"
    a.email = "jon." + String.random(8) + "@stepitup.org"  #"jon.warnow@siu.org"
    a.street = "1370 Mission St."
    a.city = "San Francisco"
    a.state = "CA"
    a.postal_code = "94114"
    a.password = "secret" 
    a.password_confirmation = "secret" 
    a.activated_at = 1.day.ago
    a.site_id = 2
	end

  attributes_for :zip_code do |a|
    
	end

end
