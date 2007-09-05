require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :users

  def test_should_create_user
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    assert_difference User, :count do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

=begin
  def test_should_require_login
    assert_no_difference User, :count do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end
=end

  def test_should_require_password
    assert_no_difference User, :count do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference User, :count do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference User, :count do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:quentin), User.authenticate('quentin@example.com', 'new password')
  end

  def test_should_not_rehash_password
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).update_attributes(:login => 'quentin2', :email => 'quentin2@example.com')
    assert_equal users(:quentin), User.authenticate('quentin2@example.com', 'test')
  end

  def test_should_authenticate_user
    assert_equal users(:quentin), User.authenticate('quentin@example.com', 'test')
  end

  def test_should_set_remember_token
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    users(:quentin).forget_me
    assert_nil users(:quentin).remember_token
  end

  def test_some_democracy_in_action_bullshit
#    $DEBUG = true
    u = User.new :email => 'seth@rd.org', :first_name => 'seth', :last_name => 'walker', :democracy_in_action => {:supporter => {:Occupation => 'hacktivist'}, :supporter_custom => {:BLOB0 => 'some info'}}
    u.instance_eval { def password_required?; false; end }
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111)
    u.save!
    assert_equal u.first_name, 'seth'
    # assert dia tries to do something
  end
  protected
    def create_user(options = {})
      User.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    end
end
