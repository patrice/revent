class EventsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :destroy]
#  access_control [:edit, :update, :destroy, :create] => 'admin'
  include DaysOfAction::Geo

  caches_page :index, :total, :by_state
#  after_filter { |c| c.cache_page(nil, :permalink => c.params[:permalink]) if c.action_name == 'show' }
  before_filter(:only => :show) {|c| c.request.env["HTTP_IF_MODIFIED_SINCE"] = nil} #don't 304
  caches_action :show
  def action_fragment_key(options)
    key = url_for(options).split('://').last
    key << "&#{cache_version_key}=#{cache_version}"
    key << "&partner=#{cookies[:partner]}" if cookies[:partner]
    key
  end

  def cache_version
    Cache.get(cache_version_key) { rand(10000) }
  end

  def cache_version_key
    "site_#{Site.current.id}_#{self.class.to_s.underscore}_#{action_name}_cache_version"
  end

  after_filter :cache_search_results, :only => :search

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def tagged
    tag = Tag.find_by_name(params[:id])
    @events = tag.nil? ? [] : tag.events
#    @event_pages = Paginator.new self, @events.length, 10, params[:page]
  end

  def flashmap
    @events = @calendar.events.find(:all, :conditions => ["postal_code != ?", 0], :joins => "INNER JOIN zip_codes ON zip_codes.zip = postal_code", :select => "events.*, zip_codes.latitude as zip_latitude, zip_codes.longitude as zip_longitude")
    respond_to do |format|
      format.xml { render :layout => false }
    end
    cache_page nil, :permalink => params[:permalink]
  end

  def total
    render :layout => false
  end
  
  def list 
    @event_pages, @events = paginate :events, :per_page => 10 
  end

  def show
    @event = @calendar.events.find(params[:id], :include => [:blogs, {:reports => :attachments}])
    if @event.latitude && @event.longitude
      @map = Cartographer::Gmap.new('eventmap')
      @map.init do |m|
        m.center = [@event.latitude, @event.longitude]
        m.controls = [:zoom, :large]
        m.zoom = 15
      end
      @icon = Cartographer::Gicon.new(:image_url => '/images/green_dot.png', :shadow_url => '', :width => 10, :height => 10, :anchor_x => 5, :anchor_y => 5)
      @map.icons << @icon
      @marker = Cartographer::Gmarker.new( :position => [@event.latitude, @event.longitude], :icon => @icon.name )
      @map.markers << @marker
    else
      @map = false
    end
  end

  def new
    @event = Event.new
    if cookies[:partner]
      self.class.ignore_missing_templates = true #themes only
      render "events/partners/#{cookies[:partner]}/new"
      self.class.ignore_missing_templates = false
    end
  end

  def partner_signup
    @event = Event.new
    self.class.ignore_missing_templates = true #themes only
    render "events/partners/#{params[:partner]}/new"
    self.class.ignore_missing_templates = false
  end

  def create
    @user = User.find_or_initialize_by_site_id_and_email(Site.current.id, params[:user][:email]) # or current_user
    @user.attributes = params[:user].reject {|k,v| [:password, :password_confirmation].include?(k.to_sym)}
    unless @user.crypted_password || (@user.password && @user.password_confirmation)
      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      @user.password = @user.password_confirmation = password
    end
    @event = @calendar.events.build(params[:event])

    if @user.valid? && @event.valid?
      @user.create_profile_image(params[:profile_image]) unless !params[:profile_image] || !params[:profile_image][:uploaded_data] || params[:profile_image][:uploaded_data].blank?
      @user.save!
      @event.host = @user
      @event.save!
      flash[:notice] = 'Event was successfully created.'
      expire_page_caches(@event)
      redirect_to @calendar.signup_redirect and return if @calendar.signup_redirect
      redirect_to :action => 'show', :id => @event.id
    else
      flash[:notice] = 'There was a problem creating your event.'
      render :action => 'new'
    end
  end

  def edit
    @event = @calendar.events.find(params[:id])
  end

  def update
    @event = @calendar.events.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      expire_page_caches(@event)
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    @calendar.events.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def rsvp
    @user = User.find_or_initialize_by_site_id_and_email(Site.current.id, params[:user][:email]) # or current_user
    @user.attributes = params[:user].reject {|k,v| [:password, :password_confirmation].include?(k.to_sym)}
    unless @user.crypted_password || (@user.password && @user.password_confirmation)
      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      @user.password = @user.password_confirmation = password
    end

    @rsvp = Rsvp.new(:event_id => params[:id])
    if @user.valid? && @rsvp.valid?
      @user.save
      @rsvp.user_id = @user.id
      @rsvp.save
      flash[:notice] = 'RSVP was successfully registered.'
      redirect_to :action => 'show', :id => @rsvp.event.id and return
    else
      flash.now[:notice] = 'There was a problem registering your RSVP.'
      @event = @rsvp.event
      render :action => 'show', :id => @event.id
    end
  end
  
  def reports
    if params[:id]
      @event = @calendar.events.find(params[:id], :include => :reports)
    else
      redirect_to :controller => :reports, :action => :index
    end
  end

  def nearby_events
    postal_code = params[:postal_code]
    unless postal_code.blank?
      begin
        @nearby_events = @calendar.events.find(:all, :origin => postal_code, :within => 25)
      rescue GeoKit::Geocoders::GeocodeError
        render(:text => "could not find that postal code", :layout => false) and return
      end
      unless @nearby_events.empty?
        render(:partial => 'shared/nearby_events', :layout => false) && return
      end
    end
    render :nothing => true
  end

  def host
    @event = @calendar.events.find(params[:id], :include => :host)
    @host = @event.host
  end

  def index
    redirect_to home_url
  end

  def search
    extract_search_params
    render 'calendars/show' and return unless @events
    @map = Cartographer::Gmap.new('eventmap')
    @map.init do |m|
      m.center = @map_center || [37.160317,-95.800781]
      m.zoom = @map_zoom || 3
      m.controls = [:zoom, :large]
    end
    @icon = Cartographer::Gicon.new(:image_url => '/images/green_dot.png', :shadow_url => '', :width => 10, :height => 10, :anchor_x => 5, :anchor_y => 5)
    @map.icons << @icon
    @events.each do |e|
      marker = nil
#      autoload_missing_constants do
#      marker = Cache.get("event_#{e.id}_marker") do
        coordinates = false
        if e.latitude && e.longitude
          coordinates = [e.latitude, e.longitude]
        elsif e.zip_latitude && e.zip_longitude
          coordinates = [e.zip_latitude, e.zip_longitude]
        end
        marker = coordinates ? Cartographer::Gmarker.new( 
        :name => "event_#{e.id}_marker",
        :position => coordinates,
#        :click => "window.location.href='#{url_for :controller => 'events', :action => 'show', :id => e.id}';",
        :info_window => render_to_string(:partial => 'info_window', :locals => {:event => e}),
        :icon => @icon.name ) : nil
#      end
#      end
      @map.markers << marker if marker
    end
#    latitudes = @events.collect {|e| e.latitude}.compact.sort
#    longitudes = @events.collect {|e| e.longitude}.compact.sort
#    @bounds = [latitudes.first, longitudes.first]
  end

  def cache_search_results
    if params[:state]
      cache_page
    end
  end

  def extract_search_params
    if params[:zip] && !params[:zip].empty?
      by_zip
    elsif params[:state] && !params[:state].empty?
      by_state
    end
  end

  def by_zip
    @search_area = params[:zip]
    @zip = ZipCode.find_by_zip(params[:zip])
    flash.now[:notice] = "Could not locate that zip code" and return unless @zip
    @map_center = [@zip.latitude,@zip.longitude]
    @map_zoom = 12
    @zips = @zip.find_objects_within_radius(50) do |min_lat, min_lon, max_lat, max_lon|
      ZipCode.find(:all, 
                   :conditions => [ "(latitude > ? AND longitude > ? AND latitude < ? AND longitude < ? ) ", 
                        min_lat, 
                        min_lon, 
                        max_lat, 
                        max_lon])
    end
    @codes = @zips.collect {|z| z.zip}
    @events = @calendar.events.find(:all, :conditions => ["postal_code IN (?)", @codes])

    @events = @events.sort_by {|e| @codes.index(e.postal_code)}

    @events.each {|e| e.instance_variable_set(:@distance_from_search, @zips.find {|z| z.zip == e.postal_code}.distance_to_search_zip) }

    @auto_center = true
  end

  def by_state
    @search_area = params[:state]
    @events = @calendar.events.find(:all, :conditions => ["state = ?", params[:state]])
    @map_center = DaysOfAction::Geo::STATE_CENTERS[params[:state].to_sym]
    @map_zoom = DaysOfAction::Geo::STATE_ZOOM_LEVELS[params[:state].to_sym]
  end

  def description
    @event = @calendar.events.find(params[:id])
    render :update do |page|
      page.replace_html 'report_event_description', "<h3>Event Description</h3>#{@event.description}"
      page.show 'report_event_description'
    end
  end

  protected
    def expire_page_caches(event = nil)
      FileUtils.rm_rf(Dir.glob(File.join(RAILS_ROOT,'tmp','cache','*')))
      FileUtils.rm_rf(File.join(RAILS_ROOT,'public','events')) rescue Errno::ENOENT
      FileUtils.rm(File.join(RAILS_ROOT,'public','index.html')) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Caches fully swept.")
    end
    #hmm, why is this here? oh yes, for objects retrieved from memcache?
    def autoload_missing_constants
      yield
#    rescue ArgumentError, MemCache::MemCacheError => error
    rescue ArgumentError
      lazy_load ||= Hash.new { |hash, key| hash[key] = true; false }
      retry if error.to_s.include?('undefined class') && 
        !lazy_load[error.to_s.split.last.constantize]
      raise error
    end  

end
