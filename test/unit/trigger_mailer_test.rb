require File.dirname(__FILE__) + '/../test_helper'

class TriggerMailerTest < Test::Unit::TestCase
  fixtures :sites, :calendars, :events, :users

  def test_host_reminder
=begin
    Site.current = sites(:main)
    @event = events(:dayofaction_sf)
    @host = @event.host
    response = ReportMailer.create_host_reminder(@event)
    assert_equal(@host.email, response.to[0])
    assert_match(/Dear #{@host.first_name}/, response.body)
=end
  end
end
