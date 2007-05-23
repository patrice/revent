class EventsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :destroy, :create]
  access_control [:edit, :update, :destroy, :create] => 'admin'
  include DaysOfAction::Geo

  caches_page :index, :show, :flashmap, :total, :by_state
  caches_action :ally
  after_filter :cache_search_results, :only => :search

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def ally
    index
    redirect_to home_url
  end

  def tagged
    @calendar = Calendar.find(1)
    tag = Tag.find_by_name(params[:id])
    @events = tag.nil? ? [] : tag.events
#    @event_pages = Paginator.new self, @events.length, 10, params[:page]
  end

  def flashmap
    @events = Event.find(:all, :conditions => ["postal_code != ?", 0], :joins => "INNER JOIN zip_codes ON zip_codes.zip = postal_code", :select => "events.*, zip_codes.latitude as zip_latitude, zip_codes.longitude as zip_longitude")
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end

  def total
    render :layout => false
  end

  def list
    @event_pages, @events = paginate :events, :per_page => 10
  end

  def show
    @event = Event.find(params[:id], :include => [:blogs, {:reports => :attachments}])
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
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      expire_page_caches(@event)
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      expire_page_caches(@event)
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def rsvp
    @rsvp = Rsvp.new(:event_id => params[:id])
    if request.post?
      @rsvp.user_id = current_user
      @rsvp.update_attributes(params[:rsvp])
      flash[:notice] = 'rsvpd'
      redirect_to :action => 'show', :id => @rsvp.event.id and return
    end
  end

  def reports
    if params[:id]
      @event = Event.find(params[:id], :include => :reports)
    else
      redirect_to :controller => :reports, :action => :index
    end
  end

  def index
    @calendar = Calendar.find(1, :include => :events)
    @events = @calendar.events
  end

  def search
    extract_search_params
    @calendar = Calendar.find(1)
    render :action => 'index' and return unless @events
    @calendar = Calendar.find(1)
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
      #autoload_missing_constants do
      #marker = Cache.get("event_#{e.id}_marker") do
        coordinates = false
        if e.latitude && e.longitude
          coordinates = [e.latitude, e.longitude]
        elsif e.zip_latitude && e.zip_longitude
          coordinates = [e.zip_latitude, e.zip_longitude]
        end
        coordinates ? Cartographer::Gmarker.new( 
        :name => "event_#{e.id}_marker",
        :position => coordinates,
#        :click => "window.location.href='#{url_for :controller => 'events', :action => 'show', :id => e.id}';",
        :info_window => render_to_string(:partial => 'info_window', :locals => {:event => e}),
        :icon => @icon.name ) : nil
      #end
      #end
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
    @events = Event.find(:all, :conditions => ["postal_code IN (?)", @codes])

    @events = @events.sort_by {|e| @codes.index(e.postal_code)}

    @events.each {|e| e.instance_variable_set(:@distance_from_search, @zips.find {|z| z.zip == e.postal_code}.distance_to_search_zip) }

    @auto_center = true
  end

  def by_state
    @search_area = params[:state]
    @events = Event.find(:all, :conditions => ["state = ?", params[:state]])
    @map_center = DaysOfAction::Geo::STATE_CENTERS[params[:state].to_sym]
    @map_zoom = DaysOfAction::Geo::STATE_ZOOM_LEVELS[params[:state].to_sym]
  end

  def description
    @event = Event.find(params[:id])
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
=begin
    def autoload_missing_constants
      yield
    rescue ArgumentError, MemCache::MemCacheError => error
      lazy_load ||= Hash.new { |hash, key| hash[key] = true; false }
      retry if error.to_s.include?('undefined class') && 
        !lazy_load[error.to_s.split.last.constantize]
      raise error
    end  
=end
end
