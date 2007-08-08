require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'

require 'mocha'

# Re-raise errors caught by the controller.
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < Test::Unit::TestCase
  fixtures :users, :sites, :calendars

  def setup
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'test'
    assert session[:user]
    assert_response :redirect
  end

  def test_should_login_and_redirect_with_democracy_in_action
    set_use_democracy_in_action_auth

    post :login, :email => 'test@test.com', :password => 'password'
    assert @controller.site.use_democracy_in_action_auth?
    assert session[:user]
    assert_equal session[:user].class, DemocracyInActionSupporter
    assert session[:user].Email='test@test.com'
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:user]
    assert_response :success
  end

  def test_should_fail_login_and_not_redirect_with_democracy_in_action
    set_use_democracy_in_action_auth
    post :login, :email => 'test@test.com', :password => 'bad password'
    assert_nil session[:user]
    assert_response :success
  end

  def test_profile_with_democracy_in_action
    set_use_democracy_in_action_auth
    post :login, :email => 'test@test.com', :password => 'password'
    get :profile
    assert_response :success
    assert_template 'profile'
  end

  def test_should_allow_signup
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    assert_difference User, :count do
      create_user
      assert_response :redirect
    end
  end

=begin
  def test_should_require_login_on_signup
    assert_no_difference User, :count do
      create_user(:login => nil)
      assert assigns(:user).errors.on(:login)
      assert_response :success
    end
  end
=end

  def test_should_require_password_on_signup
    assert_no_difference User, :count do
      create_user(:password => nil)
      assert assigns(:user).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference User, :count do
      create_user(:password_confirmation => nil)
      assert assigns(:user).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference User, :count do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end

  def test_should_logout
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    login_as :quentin
    get :logout
    assert_nil session[:user]
    assert_response :redirect
  end

  def test_should_remember_me
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    post :login, :login => 'quentin', :password => 'test', :remember_me => "1"
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    post :login, :login => 'quentin', :password => 'test', :remember_me => "0"
    assert_nil @response.cookies["auth_token"]
  end
  
  def test_should_delete_token_on_logout
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    login_as :quentin
    get :logout
    assert_equal @response.cookies["auth_token"], []
  end

  def test_should_login_with_cookie
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).remember_me
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :index
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :index
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    users(:quentin).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :index
    assert !@controller.send(:logged_in?)
  end

  protected
    def create_user(options = {})
      post :signup, :user => { :login => 'quire', :email => 'quire@example.com', 
        :password => 'quire', :password_confirmation => 'quire' }.merge(options)
    end
    
    def auth_token(token)
      CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    end
    
    def cookie_for(user)
      auth_token users(user).remember_token
    end

    def set_use_democracy_in_action_auth
      s = DemocracyInActionSupporter.new(:Email => 'test@test.com', :Password => Digest::MD5.hexdigest('password'))
      DemocracyInActionSupporter.stubs(:find).returns(s)
      @request.host = sites(:stepitup).host
    end
end
