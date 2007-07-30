require File.dirname(__FILE__) + '/../test_helper'
require 'reports_controller'

# Re-raise errors caught by the controller.
class ReportsController; def rescue_action(e) raise e end; end

class ReportsControllerTest < Test::Unit::TestCase
  fixtures :reports, :users, :roles, :roles_users, :sites

  def setup
    @controller = ReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_list
    login_as :quentin
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:reports)
  end

  def test_show
    get :show, :event_id => 1

    assert_response :success
    assert_template 'show'

    assert !assigns(:event).reports.empty?
    assert assigns(:event).reports.first.valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:report)
  end

  def test_create
    num_reports = Report.count

    Akismet.any_instance.expects(:comment_check).returns(false)
    post :create, :report => { :event_id => 1, :reporter_name => 'create', :reporter_email => 'create@create.com', :text => 'hi', }, :press_links => [{:url => 'http://link_to.com', :text => 'title'}], :attachments => []
    @report = Report.find(:all).last
    assert_equal @report.press_links.first.url, 'http://link_to.com'

    assert_response :redirect
    assert_redirected_to :action => 'index'

    assert_equal num_reports + 1, Report.count
  end

  def test_edit
    login_as :quentin
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

  def test_update
    login_as :quentin
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    login_as :quentin
    assert_not_nil Report.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Report.find(1)
    }
  end
end
