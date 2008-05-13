require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class DemocracyInActionEventTest < Test::Unit::TestCase
  def setup
    $DEBUG=true
  end

  def teardown
    $DEBUG=false
  end

  def test_save
    assert true
    return unless false # if CONNECT_TO_REMOTE_FOR TEST and move to plugin or something
    now = Time.now.to_i
    my_event = DemocracyInActionEvent.new(:Event_Name => "Event #{now}")
    key = my_event.save
    dia_event = DemocracyInActionEvent.find(key)
    assert_equal dia_event.Event_Name, my_event.Event_Name
    dia_event.destroy
    assert !DemocracyInActionEvent.find(key)
  end
end
