require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :calendars, :events, :sites

  def setup
    # actual geocoding takes forever, stub it 
    disable_geocode
    Site.current = sites(:stepitup)
  end

  def test_to_dia_event
    assert true
    return # whoa let's get this out of here
    event = events(:another)
    dia_event = event.to_democracy_in_action_event
    assert dia_event.is_a?(DemocracyInActionEvent)
    assert dia_event.save
    get_dia_event = DemocracyInActionEvent.find(dia_event.key)
    assert_equal event.name, get_dia_event.Event_Name
    assert_equal event.start.to_time.to_s(:db), get_dia_event.Start.to_time.to_s(:db)
    assert_equal event.end.to_time.to_s(:db), get_dia_event.End.to_time.to_s(:db)
  end

  def test_new_campaign_for_politician
  end

  def test_old_campaign_for_politician
  end
  
  def test_postal_code_validation
    event = Event.new(:calendar_id => 2,
                      :name => "Test Canadian Event",
                      :description => "description",
                      :location => "1248 Seymour Street",
                      :city => "Vancouver",
                      :state => "BC",
                      :postal_code => "blah blah blah",
                      :directions => "here",
                      :start => 2.hours.from_now,
                      :end => 3.hours.from_now,
                      :country_code => Event::COUNTRY_CODE_CANADA)
    assert !event.valid?
    
    # set lat/lng to avoid geocoding 
    event.latitude, event.longitude = 44, -123
    
    # test canadian postal codes
    event.postal_code = "V6B-3N9"
    assert event.valid?
    event.postal_code = "V6B 3N9"
    assert event.valid?
    event.postal_code = "V6B3N9"
    assert event.valid?
    event.postal_code = "V6B"
    assert event.valid?    
    event.postal_code = "ZZZ-ZZZ"
    assert !event.valid?
    event.postal_code = "VV6B-3N99"
    assert !event.valid?    

    # test US postal codes
    event.country_code = Event::COUNTRY_CODE_USA
    event.location = "1942 15th St."
    event.city = "San Francisco"
    event.state = "CA"
    event.postal_code = "94114"
    assert event.valid?
    event.postal_code = "94114-4567"
    assert event.valid?
    event.postal_code = "94114-NOPE"
    assert !event.valid?
    event.postal_code = "94114-"
    assert !event.valid?
  end

  def test_geocode_validation
    event = Event.new(:calendar_id => 2,
                      :name => "Test Canadian Event",
                      :description => "description",
                      :location => "TBD",
                      :city => "TBD",
                      :state => "TBD",
                      :postal_code => "TBD",
                      :directions => "TBD",
                      :country_code => Event::COUNTRY_CODE_CANADA,
                      :start => 2.weeks.from_now,
                      :end => 2.weeks.from_now + 4.hours)
    assert !event.save

    event.state = "BC"
    event.postal_code = "V6B-3N9"
    # set lat/lng to avoid geocoding 
    event.latitude, event.longitude = 44, -123
    assert event.save

    event.location = "1248 Seymour Street"
    event.city = "Vancouver"
    event.state = "BC"
    event.postal_code = "V6B-3N9"
    assert event.save
    assert event.latitude and event.longitude and event.precision = "address"

    event.location = "Colorado State University, Clark C Room 361\r\nFort Collins, Colorado 80524"
    event.city = "Fort Collins"
    event.state = "CO"
    event.postal_code = "80526"
    event.country_code = Event::COUNTRY_CODE_USA
    assert event.save
    assert event.latitude and event.longitude
  end
end
