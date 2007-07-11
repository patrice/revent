require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :events

  def test_to_dia_event
    event = events(:another)
    dia_event = event.to_democracy_in_action_event
    assert dia_event.is_a?(DemocracyInActionEvent)
    assert dia_event.save
    get_dia_event = DemocracyInActionEvent.find(dia_event.key)
    assert_equal event.name, get_dia_event.Event_Name
    assert_equal event.start.to_time.to_s(:db), get_dia_event.Start.to_time.to_s(:db)
    assert_equal event.end.to_time.to_s(:db), get_dia_event.End.to_time.to_s(:db)
  end
end