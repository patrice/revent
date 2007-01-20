class EventsController < ApplicationController
  ADMIN_METHODS = [:new, :create, :list, :edit, :update, :destroy, :publish, :unpublish]
  session :disabled => false, :only => ADMIN_METHODS
  before_filter :login_required, :only => ADMIN_METHODS
  access_control ADMIN_METHODS => 'admin'

  include DaysOfAction::Geo

  caches_page :show

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_pages, @events = paginate :events, :per_page => 10
  end

  def show
    @event = Event.find(params[:id], :include => [:reports => [:attachments]])
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
    @event = Event.find(params[:id], :include => :reports)
  end

  def index
    @calendar = Calendar.find(1)

    @map = Cartographer::Gmap.new( 'nationalmap' )
    @map.init do |m|
      m.center = [37.160317,-95.800781]
      m.zoom = 3
      m.controls = [:zoom, :large]
      m.debug = true
    end
    require 'google_geocode'
    gg = GoogleGeocode.new 'ABQIAAAA9C-o-5_7dL0qOO28APyPUxQ2WXyPj6XHTbmLYROhNmBusUo8jRQoG-wSQAaDAoAcjXHg7JK2z_Aqew'
    @events = @calendar.events
    Struct.new('LocStruct', :coordinates)
    @events.each do |e|
      if e.latitude && e.longitude
        location = Struct::LocStruct.new([e.latitude,e.longitude])
      else
        begin
          location = gg.locate e.location
        rescue GoogleGeocode::AddressError
          location = gg.locate e.postal_code
        end
      end
      @map.markers << Cartographer::Gmarker.new( :position => location.coordinates )
    end
  end

  def search
    @calendar = Calendar.find(1, :include => :events)
    @events ||= @calendar.events
    @map = Cartographer::Gmap.new('eventmap')
    @map.init do |m|
      m.center = @map_center || [37.160317,-95.800781]
      m.zoom = @map_zoom || 3
      m.controls = [:zoom, :large]
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
    search
    render :action => "search"
  end

  def by_state
    @search_area = params[:state]
    @map_center = DaysOfAction::Geo::STATE_CENTERS[params[:state].to_sym]
    @map_zoom = 4
    search
    render :action => "search"
  end

  def description
    @event = Event.find(params[:id])
    render :update do |page|
      page.replace_html 'report_event_description', "<h3>Event Description</h3>#{@event.description}"
      page.show 'report_event_description'
    end
  end
end