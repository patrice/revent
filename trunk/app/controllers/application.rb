# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
#  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }
  #layout 'tmaction'
  layout :get_layout_from_domain
  #layout :get_layout_from_route

  before_filter :set_site
  helper_method  :site
  attr_reader    :site

  theme :get_theme_from_site

  def set_site
    host = request.host
    @site ||= Site.find_by_host(host) || Site.find(:first)
  end

  def get_theme_from_site
    site.theme
  end

  def get_layout_from_route
    if 'truemajority' == params[:host]
      return 'tmaction'
    else
      return 'truemajority'
    end
  end

  def get_layout_from_domain
    case request.host
    when 'americasaysno.radicaldesigns.org', 'local_americasaysno.org'
      'truemajority'
    when 'truemajorityaction.radicaldesigns.org'
      'tmaction'
    when 'events.stepitup2007.org', 'local_stepitup.org'
      'stepitup'
    else
      'truemajority'
    end
  end
end
