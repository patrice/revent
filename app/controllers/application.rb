# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionLoggable
  before_filter :login_from_cookie
  session :session_key => '_daysofaction_session_id'
#  session :off, :if => Proc.new { |req| !(true == req.parameters[:admin]) }

  before_filter  :clean
  before_filter  :set_site, :set_calendar
  before_filter  :set_calendar
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
    Calendar #need this for instantiating from memcache, could also override autoload_missing_constants like we do in events_controller
    Site.current ||= Cache.get("site_for_host_#{request.host}") { Site.find_by_host(request.host) }  #, :include => :calendars) }
    raise 'no site' unless site
  end

  def set_calendar
    @calendar = site.calendars.detect {|c| params[:permalink] == c.permalink } || site.calendars.current || site.calendars.first    
    raise 'no calendar' unless @calendar
  end

  theme :get_theme
  def get_theme
    return @calendar.theme if @calendar && @calendar.theme
    site.theme if site
  end

  def render_optional_error_file(status_code)
    status = interpret_status(status_code)
    theme_path = File.join(Theme.path_to_theme(current_theme), "#{status[0,3]}.html")
    path = "#{RAILS_ROOT}/public/#{status[0,3]}.html"
    if File.exist?(theme_path)
      render :file => theme_path, :status => status
    elsif File.exist?(path)
      render :file => path, :status => status
    else
      head status
    end
  end
end
