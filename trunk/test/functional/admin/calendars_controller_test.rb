require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/calendars_controller'

# Re-raise errors caught by the controller.
class Admin::CalendarsController; def rescue_action(e) raise e end; end

class Admin::CalendarsControllerTest < Test::Unit::TestCase
  fixtures :calendars, :users, :roles, :roles_users

  def setup
    @controller = Admin::CalendarsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    #assert_requires_login(:quentin) {|c| c.get :index} 
    login_as :quentin
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    #assert_requires_login(:quentin) {|c| c.get :list}
    login_as :quentin
    get :list
    
    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:calendars)
  end

  def test_show
    #assert_requires_login(:quentin) {|c| c.get :show, :id => 1}
    login_as :quentin
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:calendar)
    assert assigns(:calendar).valid?
  end

  def test_new
    #assert_requires_login(:quentin) {|c| c.get :new}
    login_as :quentin
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:calendar)
  end

  def test_edit
    #assert_requires_login(:quentin) {|c| c.get :edit, :id => 1}
    login_as :quentin
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:calendar)
    assert assigns(:calendar).valid?
  end
end
