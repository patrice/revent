require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class DemocracyInActionSupporterTest < Test::Unit::TestCase
  def test_authenticate
    s = stub('supporter', :Email => 'test@test.com', :Password => Digest::MD5.hexdigest('password'))
    DemocracyInActionSupporter.stubs(:find).returns(s)
    assert_equal s, DemocracyInActionSupporter.authenticate('test@test.com', 'password')
    assert_equal nil, DemocracyInActionSupporter.authenticate('test@test.com', 'wrongpassword')
  end
end
