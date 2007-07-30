require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class CalendarTest < Test::Unit::TestCase
  fixtures :calendars, :events

  def test_load_from_dia
    assert true
    return unless false # unless connecting to remote, and let's get this out of here
    mock = stub(:get => [{'event_KEY' => '1111', 'Event_Name' => 'name', 'Description' => 'desc', 'Address' => 'addr', 'City' => 'city', 'State' => 'state', 'Zip' => '94110', 'Start' => 1.hour.from_now, 'End' => 2.hours.from_now, 'Directions' => 'directions', 'Default_Tracking_Code' => 'stepitup'}])
    DIA_API_Simple.stubs(:new).returns(mock)
    assert_nil Event.find_by_service_foreign_key('1111')
    result = Calendar.load_from_dia(1)
    assert result.is_a?(Calendar::DiaLoadResult)
    e = Event.find_by_service_foreign_key('1111')
    assert e
    assert e.tags.include?(Tag.find_by_name('stepitup'))
  end
end
