# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }
  #layout 'tmaction'
  layout 'truemajority'
end
