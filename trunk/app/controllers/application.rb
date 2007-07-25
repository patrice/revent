# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
#  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }

  before_filter :set_referrer_cookie
  def set_referrer_cookie
    if %w(exxposeexxon moveon).include? params[:referrer]
      cookies[:referrer] = {:value => @referrer = params[:referrer], :expires => "2007-05-01".to_time}
    end
  end
  helper_method :referrer
  def referrer
    @referrer ||= cookies[:referrer]
  end

  before_filter :set_site
  helper_method  :site
  attr_reader    :site

  theme :get_theme

  def set_site
    host = request.host
    @site ||= Site.find_by_host(host)
  end

  def get_theme
    if params[:ally] == 'nowarnowarming'
      return 'nowarnowarming'
    end
    get_theme_from_site
  end

  def get_theme_from_site
    site.theme if site
  end
end
