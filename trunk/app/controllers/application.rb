# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
#  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }

  before_filter  :clean
  before_filter  :set_site, :set_calendar
  helper_method  :site
  before_filter  :set_cartographer_keys
  before_filter  :set_cache_root

  def set_cache_root
	  self.class.page_cache_directory = File.join([RAILS_ROOT, (RAILS_ENV == 'test' ? 'tmp' : 'public'), 'cache', site.host])
	end

  def set_cartographer_keys
    Cartographer::Header.send :cattr_accessor, :keys
    Cartographer::Header.keys = YAML.load_file(File.join(Site.current_config_path, 'cartographer-config.yml'))
  end

  def clean
    Site.current = nil
    true
  end

  def site
    Site.current
  end

  def set_site
    Site.current ||= Site.find_by_host(request.host, :include => :calendars)
    raise 'no site' unless site
  end

  def set_calendar
    @calendar = site.calendars.detect {|calendar| params[:permalink] == calendar.permalink } || site.calendars.current || site.calendars.first    
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

  def render_404
    if File.exists?(file = File.join(Theme.path_to_theme(current_theme), '404.html'))
      render :file => file, :status => "404 Not Found"
    else
      render :file => "#{RAILS_ROOT}/public/404.html", :status => "404 Not Found"
    end
  end

  def render_500
    if File.exists?(file = File.join(Theme.path_to_theme(current_theme), '500.html'))
      render :file => file, :status => "500 Error"
    else
      render :file => "#{RAILS_ROOT}/public/500.html", :status => "500 Error"
    end
  end
end
