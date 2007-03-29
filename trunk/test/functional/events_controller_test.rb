require File.dirname(__FILE__) + '/../test_helper'
require 'events_controller'

# Re-raise errors caught by the controller.
class EventsController; def rescue_action(e) raise e end; end

class EventsControllerTest < Test::Unit::TestCase
  fixtures :events, :sites, :users

  def setup
    @controller = EventsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_set_site_from_host
    @request.host = sites(:stepitup).host
    get :index
    assert @controller.site
    assert_equal @controller.site, sites(:stepitup)
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:events)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:event)
    assert assigns(:event).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:event)
  end

  def test_create
    login_as :quentin
    num_events = Event.count

    post :create, :event => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_events + 1, Event.count
  end

=begin
  def test_create_with_democracy_in_action
    @request.host = sites(:stepitup).host

    now = Time.now.to_i
    supporter = {:Email => "seth+#{now}@radicaldesigns.org", :First_Name => 'seth'}
    event = {:name => "Event ##{now}", :description => "event #{now} description",
      :location => 'here', :city => 'there', :state => 'CA', :postal_code => '94110',
      :directions => 'come', :start => 1.hour.from_now, :end => 2.hours.from_now, :calendar_id => 1}
    DIA_API_Simple.expects(:process).with(supporter).returns(1111)
    num_events = Event.count
    post :create, :event => {}, :democracy_in_action_supporter => supporter
    assert_equal num_events + 1, Event.count
#    assert_exists_in_dia @event
    #    assert_links
  end
=end

  def test_create_with_invalid_democracy_in_action_supporter
  end

  def test_create_with_invalid_democracy_in_action_event
  end

  def test_edit
    login_as :quentin
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:event)
    assert assigns(:event).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to login_url
  end

  def test_destroy
    login_as :quentin
    assert_not_nil Event.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Event.find(1)
    }
  end
end
