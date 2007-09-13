require File.dirname(__FILE__) + '/../test_helper'
require 'events_controller'

# Re-raise errors caught by the controller.
class EventsController; def rescue_action(e) raise e end; end

class EventsControllerTest < Test::Unit::TestCase
  fixtures :events, :sites, :users, :calendars, :democracy_in_action_objects

  def setup
    @controller = EventsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_set_site_from_host
    @request.host = sites(:stepitup).host
    get :index
    assert_equal @controller.site.host, 'events.stepitup2007.org'
    assert_equal @controller.site, sites(:stepitup)
  end

  def test_index
    get :index
    assert_response :redirect
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
    get :new, :calendar_id => 1

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:event)
  end

  def test_create_with_new_user
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    num_events = Event.count
    assert !User.find_by_email('new@event.com')

    post :create, :calendar_id => 1,
      :user => {:login => 'mylogin', :first_name => 'user', :last_name => 'name', :email => 'new@event.com'},
      :event => {:name => 'some event', :description => 'a description', :city => 'city', :state => 'CA', :postal_code => '94110', :directions => 'directions', :start => 1.hour.from_now, :end => 2.hours.from_now, :calendar_id => 1, :location => 'location'}

    assert_response :redirect
    assert_redirected_to :action => 'show'
    assert_equal assigns(:event).host.email, 'new@event.com'
    assert_equal assigns(:event).calendar_id, 1

    assert u = User.find_by_email('new@event.com')
    assert u.password.blank?
    assert_equal num_events + 1, Event.count
  end

  def test_create_with_existing_user
    @request.host = sites(:stepitup).host
    DemocracyInAction::API.any_instance.stubs(:process).returns(1111) unless connect?
    user = User.create! :login => 'mylogin', :first_name => 'user', :last_name => 'name', :email => 'new@event.com', :password => 'apassword', :password_confirmation => 'apassword', :activated_at => Time.now.utc
    assert User.authenticate('new@event.com', 'apassword')
    user_count = User.count

    post :create, :calendar_id => 1,
      :user => {:login => 'mylogin', :first_name => 'user', :last_name => 'name', :email => 'new@event.com', :password => 'another', :password_confirmation => 'another'},
      :event => {:name => 'some event', :description => 'a description', :city => 'city', :state => 'CA', :postal_code => '94110', :directions => 'directions', :start => 1.hour.from_now, :end => 2.hours.from_now, :calendar_id => 1, :location => 'location'}

    assert_response :redirect
    assert_redirected_to :action => 'show'

    assert !User.authenticate('new@event.com', 'another')
    assert User.authenticate('new@event.com', 'apassword')
    assert_equal user_count, User.count
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

  def test_create_with_saving_to_democracy_in_action
    @request.host = calendars(:stepitup_oct07).site.host
    require 'democracyinaction'
    DemocracyInAction::API.any_instance.expects(:process).with('supporter',all_of(has_entry('Email', 'new@event.com'), has_entry('Organization', 'my organization'))).returns(1111)

    DemocracyInAction::API.any_instance.expects(:process).with('supporter_custom', all_of(has_entry('supporter_KEY', 1111), has_entry('BLOB0', 'some custom field'))).returns(1112)

    DemocracyInAction::API.any_instance.expects(:process).with('event', all_of(has_entry('supporter_KEY', 1111), has_entry('Event_Name', 'some event'), has_entry('distributed_event_KEY', calendars(:stepitup_oct07).democracy_in_action_object.key))).returns(1113)

    post :create, :permalink => calendars(:stepitup_oct07).permalink,
      :user => {:first_name => 'user', :last_name => 'name', :email => 'new@event.com', :democracy_in_action => {:supporter => {'Organization' => 'my organization'}, :supporter_custom => {'BLOB0' => 'some custom field'}}},
      :event => {:name => 'some event', :description => 'a description', :city => 'city', :state => 'CA', :postal_code => '94110', :directions => 'directions', :start => 1.hour.from_now, :end => 2.hours.from_now, :location => 'location'}

    assert assigns(:user).is_a?(User)
    assert assigns(:user).valid?
    assert_equal assigns(:user).democracy_in_action_object.key, 1111
    assert (event = assigns(:event).democracy_in_action_object)
    assert_equal event.key, 1113
  end

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

    DemocracyInAction::API.any_instance.expects(:delete).with('event', has_entry('key', democracy_in_action_objects(:first_event).key)).returns(true)
    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Event.find(1)
    }
  end
  
=begin
  def test_multi_site_scope
    Site.find(:all).reject {|s| s.host == sites(:nwnw).host}.each do |site|
      @request.host = site.host
      # get nwnw.daysofaction.org/nwnw1/
      get :index
      assert !assigns(:events).include(events(:nwnw_rally))
      get :list
      assert !assigns(:events).include(events(:nwnw_rally))
    end
  end

  def test_multi_site_scope_crud
    event_controller_get_actions = {:index => {}, :list => {}, :new => {}, :edit => {}, 
      :ally => {}, :flashmap => {}, :search => {}, :show => {:id => events(:nwnw_rally).id}, 
      :destroy => {:id => events(:nwnw_rally).id}, :rsvp => {:id => events(:nwnw_rally).id}, 
      :reports => {:id => events(:nwnw_rally).id}, :description => {:id => events(:nwnw_rally).id}, 
      :destroy => {:id => events(:nwnw_rally).id}}
      #, :by_zip => {:zip => events(:nwnw_rally).postal_code}, 
      #:by_state => {:state => events(:nwnw_rally).state},
    
    #get events_url(:permalink => calendars(:nwnw_cal1).permalink, :action => :action)
    @request.host = sites(:stepitup).host
    event_controller_get_actions.each do |action, params| 
      params[:permalink] = calendars(:nwnw_cal1).permalink
      #puts action.to_s + ' ' + params.to_s
      get action, params
      #assert_response :redirect
    end

  #or maybe
     assert_raises ActiveRecord::RecordNotFound do
       get (or post, etc) action, :event_id => etc
     end
  #or both
  end
=end

end
