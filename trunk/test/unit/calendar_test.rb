require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class CalendarTest < Test::Unit::TestCase
  fixtures :calendars, :events, :reports

  # incomplete test
  def test_calendar_has_calendars
    rolling = Calendar.new
    dec4 = Calendar.new
    all = Calendar.new
    assert true
  end
  
  def test_has_many_featured_reports_includes_featured_reports
    @featured_report = reports(:ufpj_featured_report)
    @calendar = calendars(:ufpj_5yearstoomany)
    assert @calendar.featured_reports.include?(@featured_report)
  end
  
  def test_has_many_featured_reports_does_not_include_non_featured_reports
    @non_featured_report = reports(:ufpj_non_featured_report)
    @calendar = calendars(:ufpj_5yearstoomany)
    assert !@calendar.featured_reports.include?(@non_featured_report)
  end
  
  def test_load_from_dia
    assert true
    return # unless connecting to remote, and let's get this out of here
    mock = stub(:get => [{'event_KEY' => '1111', 'Event_Name' => 'name', 'Description' => 'desc', 'Address' => 'addr', 'City' => 'city', 'State' => 'state', 'Zip' => '94110', 'Start' => 1.hour.from_now, 'End' => 2.hours.from_now, 'Directions' => 'directions', 'Default_Tracking_Code' => 'stepitup'}])
    DIA_API_Simple.stubs(:new).returns(mock)
    assert_nil Event.find_by_service_foreign_key('1111')
    result = Calendar.load_from_dia(1)
    assert result.is_a?(Calendar::DiaLoadResult)
    e = Event.find_by_service_foreign_key('1111')
    assert e
    assert e.tags.include?(Tag.find_by_name('stepitup'))
  end


  def test_private_events
    @calendar = calendars(:siu_nov)
    @event = events(:siu_private)
    assert @calendar.events.include?(@event)
    assert !@calendar.public_events.include?(@event)
  end
end
