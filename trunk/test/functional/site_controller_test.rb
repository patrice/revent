require File.dirname(__FILE__) + '/../test_helper'
require 'site_controller'

# Re-raise errors caught by the controller.
class SiteController; def rescue_action(e) raise e end; end

class SiteControllerTest < Test::Unit::TestCase
  fixtures :sites

  def setup
    @controller = SiteController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_set_site_from_host
    @request.host = sites(:stepitup).host
    get :index
    assert @controller.site
    assert_equal @controller.site, sites(:stepitup)
  end
end
