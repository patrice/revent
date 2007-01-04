class EventsController < ApplicationController
  @@STATE_CENTERS = {
    :AL => [34.7356758024691,-86.5923922224596],
    :AK => [53.3308100550838,-168.187470829389],
    :AZ => [36.2463773395062,-111.615135530525],
    :AR => [36.3745018333333,-92.2404553521374],
    :CA => [34.034180345679,-120.386475658584],
    :CO => [40.1123906851852,-105.837605375902],
    :CT => [41.7653157407408,-72.7500704191033],
    :DE => [39.5919031111111,-75.5734057276619],
    :DC => [38.9432264290123,-77.014843331318],
    :FL => [24.8239841227306,-80.8128505589159],
    :GA => [34.8044546604938,-83.4848125832388],
    :HI => [23.7284171581896,-166.171539079549],
    :ID => [46.0109290123457,-115.25942158465],
    :IL => [42.3841872530864,-89.4736534897358],
    :IN => [41.637323308642,-86.1259739940181],
    :IA => [43.3672035185185,-93.5547624934191],
    :KS => [39.8555297623457,-98.3303635104984],
    :KY => [38.859923462963,-84.6841789112593],
    :LA => [29.8796603709091,-88.8255873459908],
    :ME => [43.6900192271536,-70.1578640420269],
    :MD => [38.1788128833971,-76.0527088760855],
    :MA => [42.5447558209877,-71.9165613329627],
    :MI => [45.6625052222222,-85.5537117162697],
    :MN => [48.7185493950617,-94.5945829561728],
    :MS => [34.6460881388889,-89.4242207167089],
    :MO => [40.403672037037,-92.5918042214141],
    :MT => [48.4396797777778,-109.192907672176],
    :NE => [42.2346756358025,-99.9053783224672],
    :NV => [39.6569722716049,-117.034131681386],
    :NH=> [43.6958601450617,-71.5101267326957],
    :NJ => [40.9233455308642,-74.638104312308],
    :NM => [36.5294757469136,-105.857244341589],
    :NY => [40.8539188888889,-73.7699673858154],
    :NC => [36.4464627530864,-79.6107260441304],
    :ND => [48.6260139475309,-99.6237594623845],
    :OH => [41.6527994699955,-82.8207385186695],
    :OK => [36.6829932839506,-97.5522601607084],
    :OR => [45.3428610617284,-121.378793620387],
    :PA => [41.9217809814815,-78.0204010573646],
    :PR => [18.3231539012346,-65.2732113512323],
    :RI => [41.5234845535524,-71.3834372851514],
    :SC => [34.888059808642,-81.0260661357534],
    :SD => [45.6913540185185,-99.9036100826851],
    :TN => [36.4820787993827,-86.5863271120342],
    :TX => [27.6294930593335,-97.1996143438316],
    :UT => [41.3986721296296,-111.260921682652],
    :VT => [44.5024862469136,-72.7303999097772],
    :VA => [37.9466637839506,-76.0240703187518],
    :WA => [48.6648342044502,-123.174473648561],
    :WV => [39.5697930246914,-80.627783600124],
    :WI => [45.3700939324083,-86.9017926206626],
    :WY => [43.8752936296296,-107.365810650813]
    }

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

  def index
    @event_group = EventGroup.find(1)

    @map = Cartographer::Gmap.new( 'nationalmap' )
    @map.init do |m|
      m.center = [37.160317,-95.800781]
      m.zoom = 3
      m.controls = [:zoom, :large]
      m.debug = true
    end
    require 'google_geocode'
    gg = GoogleGeocode.new 'ABQIAAAA9C-o-5_7dL0qOO28APyPUxQ2WXyPj6XHTbmLYROhNmBusUo8jRQoG-wSQAaDAoAcjXHg7JK2z_Aqew'
    @events = @event_group.events
    @events.each do |e|
      location = gg.locate e.location
      @map.markers << Cartographer::Gmarker.new( :position => location.coordinates )
    end
  end

  def search
    @event_group = EventGroup.find(1)
    @events = @event_group.events
    @map = Cartographer::Gmap.new('eventmap')
    @map.init do |m|
      m.center = @map_center
      m.zoom = @map_zoom
      m.controls = [:zoom, :large]
    end
  end

  def by_zip
    @search_area = params[:zip]
    @zip = ZipCode.find_by_zip(params[:zip])
    @map_center = [@zip.latitude,@zip.longitude]
    @map_zoom = 12
    search
    render :action => "search"
  end
  def by_state
    @search_area = params[:state]
    @map_center = @@STATE_CENTERS[params[:state].to_sym]
    @map_zoom = 4
    search
    render :action => "search"
  end
end
