# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  session :session_key => '_daysofaction_session_id'
  layout 'truemajority'
end
