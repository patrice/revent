require File.dirname(__FILE__) + '/../../test_helper'
require 'account/events_controller'

# Re-raise errors caught by the controller.
class Account::EventsController; def rescue_action(e) raise e end; end

class Account::EventsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Account::EventsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
