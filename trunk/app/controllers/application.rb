# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
#  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }

  before_filter  :set_site, :set_calendar
  helper_method  :site
  attr_reader    :site

  def set_site
    @site ||= Site.find_by_host(request.host, :include => :calendars)
    raise 'no site' unless @site
  end

  def set_calendar
    @calendar = @site.calendars.detect {|calendar| params[:permalink] == calendar.permalink } || @site.calendars.current || @site.calendars.first    
    if not @calendar
      redirect_to :controller => :site, :action => :splash
      return false
    end
  end

  theme :get_theme
  def get_theme
    return @calendar.theme if @calendar && @calendar.theme
    site.theme if site
  end
end
