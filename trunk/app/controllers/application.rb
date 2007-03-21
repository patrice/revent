# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
#  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }
  layout :get_layout_from_domain

  before_filter :set_referrer_cookie
  def set_referrer_cookie
    if 'exxposeexxon' == params[:referrer]
      cookies[:referrer] = {:value => @referrer = 'exxposeexxon', :expires => "2007-05-01".to_time}
    end
  end
  helper_method :referrer
  def referrer
    @referrer ||= cookies[:referrer]
  end

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
