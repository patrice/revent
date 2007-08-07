# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
#  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }

  before_filter :set_site
  helper_method  :site
  attr_reader    :site

  def set_site
    host = request.host
    @site ||= Site.find_by_host(host, :include => :calendars)
    raise 'no site' unless @site
    @calendar = @site.calendars.detect {|calendar| params[:permalink] == calendar.permalink } || @site.calendars.current || @site.calendars.first
  end

  theme :get_theme
  def get_theme
    if site
      site.theme
    end
  end
end
