require File.dirname(__FILE__) + '/../test_helper'

class UserMailerTest < Test::Unit::TestCase

  def setup
    Site.current = Site.new(:host => 'events.radicaldesigns.org')  
    @user = User.new(:email => 'test@gmail.com')
    @events = [Event.new(:id => 111, :start => 1.day.ago, :end => (1.day.ago + 2.hours))]
    @calendar = Calendar.new(:id => 222, :admin_email => 'info@radicaldesigns.org')
    @user.stubs(:events).returns(@events)
    Event.any_instance.stubs(:calendar).returns(@calendar)
  end 

  def test_activation 
    response = UserMailer.create_activation(@user)
    assert_equal('info@radicaldesigns.org', response.from[0])
  end
  
  def test_message
    @from = User.new(:email => 'michealjordan@gmail.com')
    @event = Event.new(:id => 333, :name => 'Step It Up Rally', :city => 'San Francisco', :state => 'CA', :location => '1370 Mission St., 4th Fl.', :start => 1.day.ago, :end => (1.day.ago + 2.hours))
    @message = {:subject => 'check, check, testing, 1, 2, 3', :body => 'test upcoming/past events'}
    response = UserMailer.create_message(@from, @event, @message)
    assert_match(/took place on/, response.body)

    @event.start = 1.day.ago
    @event.end = 1.day.ago + 2.hours
    response = UserMailer.create_message(@from, @event, @message)
    assert_match(/will take place on/, response.body)
  end
end
