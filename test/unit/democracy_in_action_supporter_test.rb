require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class DemocracyInActionSupporterTest < Test::Unit::TestCase
  def setup
    $DEBUG=true
  end

  def teardown
    $DEBUG=false
  end

  def test_authenticate
    s = stub('supporter', :Email => 'test@test.com', :Password => Digest::MD5.hexdigest('password'))
    DemocracyInActionSupporter.stubs(:find).returns(s)
    assert_equal s, DemocracyInActionSupporter.authenticate('test@test.com', 'password')
    assert_equal nil, DemocracyInActionSupporter.authenticate('test@test.com', 'wrongpassword')
  end

  def test_save
    if false # if CONNECT_TO_REMOTE_FOR_TESTING (except better name) (also move this to a plugin)
    now = Time.now.to_i
    s = DemocracyInActionSupporter.new(:Email => "seth+#{now}@radicaldesigns.org", :First_Name => 'testing', :Last_Name => now)
    key = s.save
    seth = DemocracyInActionSupporter.find(key)
    assert_equal seth.First_Name, s.First_Name
    assert_equal seth.Last_Name, now.to_s
    seth.destroy
    assert !DemocracyInActionSupporter.find(key)
    end
  end
end
