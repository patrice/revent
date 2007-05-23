require File.dirname(__FILE__) + '/../test_helper'
require 'calendars_controller'

# Re-raise errors caught by the controller.
class CalendarsController; def rescue_action(e) raise e end; end

class CalendarsControllerTest < Test::Unit::TestCase
  fixtures :calendars

  def setup
    @controller = CalendarsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:calendars)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:calendar)
    assert assigns(:calendar).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:calendar)
  end

  def test_create
    num_calendars = Calendar.count

    post :create, :calendar => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_calendars + 1, Calendar.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:calendar)
    assert assigns(:calendar).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Calendar.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Calendar.find(1)
    }
  end
end
