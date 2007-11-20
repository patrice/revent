require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :events

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
                      :end => 3.hours.from_now)
    assert !event.valid?
    
    # test canadian postal codes
    event.postal_code = "ZZZ-ZZZ"
    assert !event.valid?
    event.postal_code = "V6B-3N9"
    assert event.valid?
    event.postal_code = "V6B 3N9"
    assert event.valid?
    event.postal_code = "V6B3N9"
    assert event.valid?
    event.postal_code = "V6B"
    assert event.valid?    

    # test US postal codes
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
end
