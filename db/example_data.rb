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

  places = [ {:city => 'San Francisco', :state => 'CA', :postal_code => '94114'},
      {:city => 'New York', :state => 'NY', :postal_code => '10001'},
      #{:city => 'Vancouver', :state => 'BC', :postal_code => 'V7H 1J4'},
      {:city => 'Miami', :state => 'FL', :postal_code => '33178'},
      {:city => 'Washington', :state => 'DC', :postal_code => '20001'} ]

  attributes_for :event do |e|
    e.calendar = default_calendar
    e.name = String.random #"Step It Up"
    e.location = "1 Market St."
    place = places[rand(places.length)]
    e.city = place[:city]
    e.state = place[:state]
    e.postal_code = place[:postal_code]
    e.start = Time.now + 2.months
    e.end = Time.now + 2.months + 2.hours
	end

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
   a.host = "events.stepitup.org"
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
    a.email = "jon.warnow@siu.org"
    a.password = "secret" 
    a.password_confirmation = "secret" 
    a.activated_at = 1.day.ago
    a.site = site(:stepitup)
	end

  attributes_for :zip_code do |a|
    
	end

end
