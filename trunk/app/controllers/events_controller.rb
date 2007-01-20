class EventsController < ApplicationController
  include DaysOfAction::Geo

  caches_page :show, :flashmap

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def flashmap
    @events = Event.find(:all, :conditions => ["postal_code != ?", 0])
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end

  def total
    @events = Event.find(:all)
    render :layout => false
  end

  def list
    @event_pages, @events = paginate :events, :per_page => 10
  end

  def show
    @event = Event.find(params[:id], :include => [:reports => [:attachments]])
    @map = Cartographer::Gmap.new('eventmap')
    @map.init do |m|
      m.center = [@event.latitude, @event.longitude]
      m.controls = [:zoom, :large]
      m.zoom = 15
    end
    @map.markers << Cartographer::Gmarker.new( :position => [@event.latitude,@event.longitude] )
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Event was successfully created.'
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
    @calendar = Calendar.find(1)
    extract_search_params
    @events ||= @calendar.events
    @map = Cartographer::Gmap.new('eventmap')
    @map.init do |m|
      m.center = @map_center || [37.160317,-95.800781]
      m.zoom = @map_zoom || 3
      m.controls = [:zoom, :large]
    end
    @events.each do |e|
      @map.markers << Cartographer::Gmarker.new( :position => [e.latitude,e.longitude] ) if e.latitude && e.longitude
    end
    latitudes = @events.collect {|e| e.latitude}.compact.sort
    longitudes = @events.collect {|e| e.longitude}.compact.sort
    @bounds = [latitudes.first, longitudes.first]
  end

  def extract_search_params
    if params[:zip]
      by_zip
    elsif params[:state]
      by_state
    end
  end

  def by_zip
    @search_area = params[:zip]
    @zip = ZipCode.find_by_zip(params[:zip])
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
    @events = Event.find(:all, :conditions => "postal_code IN (#{@zips.collect {|z| z.zip}.join(',')})")
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
end
