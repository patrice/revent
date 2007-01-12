# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }
  #layout 'tmaction'
  #layout :get_layout_from_domain
  layout :get_layout_from_route
  
  def get_layout_from_route
    if 'truemajority' == params[:host]
      return 'tmaction'
    else
      return 'truemajority'
    end
  end

  def get_layout_from_domain
    case request.host
    when 'americasaysno.radicaldesigns.org'
      'truemajority'
    when 'truemajorityaction.radicaldesigns.org'
      'tmaction'
    else
      'truemajority'
    end
  end
end
