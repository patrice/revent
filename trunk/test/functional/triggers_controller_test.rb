require File.dirname(__FILE__) + '/../test_helper'
require 'triggers_controller'

# Re-raise errors caught by the controller.
class TriggersController; def rescue_action(e) raise e end; end

class TriggersControllerTest < Test::Unit::TestCase
  def setup
    @controller = TriggersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
