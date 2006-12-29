class EventsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_pages, @events = paginate :events, :per_page => 10
  end

  def show
    @event = Event.find(params[:id])
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
    @event = Event.find(params[:id])
  end

  def map
    @map = Cartographer::Gmap.new( 'mymap' )
    @map.init do |m|
      m.center = [37.775558, -122.415553]
      m.zoom = 11
      m.debug = true
      m.controls = [:zoom, :large]
    end
    require 'google_geocode'
    gg = GoogleGeocode.new 'ABQIAAAA9C-o-5_7dL0qOO28APyPUxQ2WXyPj6XHTbmLYROhNmBusUo8jRQoG-wSQAaDAoAcjXHg7JK2z_Aqew'
    location = gg.locate '1370 Mission St, San Francisco, CA'
    @map.markers << Cartographer::Gmarker.new( :position => location.coordinates, :info_window => 'Clicky clicky!!', :map => @map )
    location = gg.locate '503 Cortland Ave, San Francisco, CA'
    @map.markers << Cartographer::Gmarker.new( :position => location.coordinates, :info_window => 'David blows goats', :map => @map )
  end
end
