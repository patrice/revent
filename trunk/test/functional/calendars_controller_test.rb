require File.dirname(__FILE__) + '/../test_helper'
require 'calendars_controller'

# Re-raise errors caught by the controller.
class CalendarsController; def rescue_action(e) raise e end; end

class CalendarsControllerTest < Test::Unit::TestCase
  fixtures :calendars, :sites, :events

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
  
  # check to see that events don't bleed across sites
  def test_multi_site_scope
    Site.find(:all).reject {|s| s.host == sites(:nwnw).host}.each do |site|
      @request.host = site.host
      get :show
      assert !assigns(:events).include?(events(:nwnw_sf))
    end
  end
end
