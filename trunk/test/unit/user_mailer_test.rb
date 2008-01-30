require File.dirname(__FILE__) + '/../test_helper'

class UserMailerTest < Test::Unit::TestCase

  def setup
    @user = User.new(:email => 'test@gmail.com')
    @events = [Event.new(:id => 111)]
    @calendar = Calendar.new(:id => 222, :admin_email => 'info@radicaldesigns.org')
    @user.stubs(:events).returns(@events)
    Event.any_instance.stubs(:calendar).returns(@calendar)
  end 

  def test_activation 
    Site.current = Site.new(:host => 'events.radicaldesigns.org')  
    response = UserMailer.create_activation(@user)
    assert_equal('info@radicaldesigns.org', response.from[0])
  end

end
