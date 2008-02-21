class EventsController < ApplicationController
  include DaysOfAction::Geo
  before_filter :disable_create_when_event_past, :only => [:new, :create, :rsvp]
  def disable_create_when_event_past
    if params[:id]
      @event = @calendar.events.find(params[:id]) 
      redirect_to home_url if @event.past?
    else
      redirect_to home_url if @calendar.past?
    end
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [:create, :rsvp], :redirect_to => {:action => 'index'}

  caches_page :index, :total, :by_state, :show, :simple, :international
  cache_sweeper :event_sweeper, :only => :create
  after_filter :cache_search_results, :only => :search
  def cache_search_results
    if params[:state]
      if params[:permalink]
        # cache_page accepts string for second argument in rails v2.0
        # replace url_for hash with state_search_url  once upgrade to 2.0
        cache_page nil, :permalink => params[:permalink], :controller => :events, :action => :search, :state => params[:state] 
      else
        cache_page 
      end
    end
  end

  def cache_version
    Cache.get(cache_version_key) { rand(10000) }
  end

  def cache_version_key
    "site_#{Site.current.id}_#{self.class.to_s.underscore}_#{action_name}_cache_version"
  end


  def tagged
    tag = Tag.find_by_name(params[:id])
    @events = tag.nil? ? [] : tag.events(:conditions => ["calendar_id = ?", @calendar.id])
  end

  def flashmap
    @events = @calendar.public_events.find(:all, :conditions => ["(latitude <> 0 AND longitude <> 0) AND state IS NOT NULL AND country_code = ?", Event::COUNTRY_CODE_USA])
    respond_to do |format|
      format.xml { render :layout => false }
    end
    cache_page nil, :permalink => params[:permalink]
  end

  def recently_updated
    respond_to do |format|
      format.html do 
        @events = @calendar.public_events.paginate(:all, :order => 'updated_at DESC', :page => params[:page])
      end
      format.xml do 
        @events = @calendar.public_events.find(:all, :order => 'updated_at DESC', :limit => 4)
        render :action => 'recently_updated.rxml', :layout => false
      end
    end
  end

  def recently_added 
    respond_to do |format|
      format.html do 
        @events = @calendar.public_events.paginate(:all, :order => 'created_at DESC', :page => params[:page])
      end
      format.xml do 
        @events = @calendar.public_events.find(:all, :order => 'created_at DESC', :limit => 4)
        render :action => 'recently_added.rxml', :layout => false
      end
    end
  end

  def upcoming
    respond_to do |format|
      format.html do 
        @events = @calendar.public_events.paginate(:all, :conditions => ["start > ?", Time.now], :order => 'start, state', :page => params[:page])
      end
      format.xml do 
        @events = @calendar.public_events.find(:all, :conditions => ["end >= ?", Time.now], :order => "start, state")
        render :action => 'upcoming.rxml', :layout => false
      end
    end
#    cache_page nil, :permalink => params[:permalink]
  end

  def total
    render :layout => false
  end
  
  def show
    @event = @calendar.events.find(params[:id], :include => [:blogs, {:reports => :attachments}])
    @attending_politicians = @event.attending_politicians.map {|p| p.parent || p}.uniq
    @supporting_politicians = @event.supporting_politicians.map {|p| p.parent || p}.uniq
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
    @categories = @calendar.categories.map {|c| [c.name, c.id] }
    if current_theme
      self.class.ignore_missing_templates = true #themes only
      if params[:form]
        if is_partner(params[:form])
          cookies[:partner] = {:value => params[:form], :expires => 3.hours.from_now}
          render "events/partners/#{params[:form]}/new"
        elsif is_signup(params[:form])
          render "signup/#{params[:form]}" and return
        end
      elsif cookies[:partner] && is_partner(cookies[:partner])
        render "events/partners/#{cookies[:partner]}/new"
      end
      self.class.ignore_missing_templates = false
    end
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
      @event.tags << Tag.find_or_create_by_name(params[:tag]) unless params[:tag].blank?
      redirect_to params[:redirect] and return if params[:redirect]
      redirect_to @calendar.signup_redirect and return if @calendar.signup_redirect
      flash[:notice] = 'Your event was successfully created.'
      redirect_to :action => 'show', :id => @event
    else
      flash[:notice] = 'There was a problem creating your event.'
      @categories = @calendar.categories.map {|c| [c.name, c.id] }
      render :action => 'new'
    end
  end

=begin
  def edit
    @event = @calendar.events.find(params[:id])
  end

  def update
    @event = @calendar.events.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    @calendar.events.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
=end

  def rsvp
    @event = @calendar.events.find(params[:id])
    @user = User.find_or_initialize_by_site_id_and_email(Site.current.id, params[:user][:email]) # or current_user
    @user.attributes = params[:user].reject {|k,v| [:password, :password_confirmation].include?(k.to_sym)}
    unless @user.crypted_password || (@user.password && @user.password_confirmation)
      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      @user.password = @user.password_confirmation = password
    end

    @rsvp = Rsvp.new(:event_id => params[:id])
    if @user.valid? && @rsvp.valid?
      if is_partner(cookies[:partner])
        @user.democracy_in_action ||= {}
        if @calendar.id == 8 # momsrising.fair-pay
          @user.democracy_in_action['supporter_custom'] ||= {}
          @user.democracy_in_action['supporter_custom']['VARCHAR3'] = cookies[:partner]
        else
          @user.democracy_in_action['supporter'] ||= {}
          @user.democracy_in_action['supporter']['Tracking_Code'] = "#{cookies[:partner]}_rsvp"
        end
      end
      @user.save
      @rsvp.user_id = @user.id
      @rsvp.save
      flash.now[:notice] = "<b>Thanks for the RSVP!</b><br /> An email confirming your RSVP has been sent to the email address you provided."
    else
      flash.now[:notice] = 'There was a problem registering your RSVP.'       
    end
    show  # don't call show on same line as render
    render(:action => 'show', :id => @event) && return
  end
  
  def reports
    if params[:id]
      @event = @calendar.events.find(params[:id], :include => :reports)
    else
      redirect_to :controller => :reports, :action => :index
    end
  end

  def other_state_events
    state = params[:event_state]
    unless state.blank?
      @other_state_events = @calendar.public_events.find_all_by_state(state)
      unless @other_state_events.empty?
        render(:partial => 'other_state_events', :layout => false) && return
      end
    end
    render :nothing => true    
  end

  def nearby_events
    postal_code = params[:postal_code]
    unless postal_code.blank?
      begin
        @nearby_events = @calendar.public_events.find(:all, :origin => postal_code, :within => 25)
      rescue GeoKit::Geocoders::GeocodeError
        render(:text => "", :layout => false) and return
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
    #redirect_to home_url
    redirect_to :permalink => @calendar.permalink, :controller => 'calendars', :action => 'show'
  end
  
  def international
    @country_a3 = params[:id] || 'all'
    @country_code = CountryCodes.find_by_a3(@country_a3.upcase)[:numeric] || 'all'
    if @country_code == 'all'
      @events = @calendar.public_events.paginate(:all, :conditions => ["country_code <> ?", Event::COUNTRY_CODE_USA], :order => 'country_code, city, start', :page => params[:page])
    else
      @events = @calendar.public_events.paginate(:all, :conditions => ["country_code = ?", @country_code], :order => 'start, city', :page => params[:page])
    end
  end
  
  def search
    extract_search_params
    redirect_to(:permalink => @calendar.permalink, :controller => 'calendars', :action => 'show') and return unless @events
    @categories = @calendar.categories.find(:all).map{|c| [c.name.pluralize, c.id]}
    @categories.insert(0, ["All " + @calendar.permalink.capitalize, "all"]) unless @categories.empty?
    @category = @calendar.categories.find(params[:category]) if (params[:category] and not params[:category] == 'all')
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
  
  def simple
  end


  def extract_search_params
    if params[:zip] && !params[:zip].empty?
      by_zip
    elsif params[:state] && !params[:state].empty?
      by_state
    end
  end

  def by_zip
    case params[:zip]
    when /^\d{5}(-\d{4})?$/ # US postal code
      zip = ZipCode.find_by_zip(params[:zip])
      @map_center, @state = [zip.latitude, zip.longitude], zip.state if zip
    when /^\D\d\D((-| )?\d\D\d)?$/ # Canadian postal code
      geo = GeoKit::Geocoders::MultiGeocoder.geocode(params[:zip])
      @map_center, @state = [geo.lat, geo.lng], geo.state if geo.success
    else 
      return  # let calling method redirect based on @events 
    end    
    flash.now[:notice] = "Could not find postal code" and return unless @map_center
    if params[:category] and not params[:category] == "all"
      @events = @calendar.public_events.find(:all, :origin => @map_center, :within => 50, :order => 'distance', :conditions => ['category_id = ?', params[:category]])
    else
      @events = @calendar.public_events.find(:all, :origin => @map_center, :within => 50, :order => 'distance')
    end
    @map_zoom = 12
    @auto_center = true
  end

=begin
    if params[:category] and not params[:category] == "all"
      @events = @calendar.public_events.find(:all, :origin => @map_center, :within => 50, :order => 'distance', :conditions => ["category_id = ?", params[:category]])
    else
=end

  def by_geo
    @events = @calendar.public_events.find(:all, :origin => [params[:lat], params[:lng]], :within => 50)
    @zips = ZipCode.find(:all, :origin => [params[:lat], params[:lng]], :within => 50, :order => 'distance')
    code = @zips.first.zip
    @district = Cache.get "district_for_postal_code_#{code}" do
      dia_warehouse = "http://warehouse.democracyinaction.org/dia/api/warehouse/append.jsp?id=radicaldesigns".freeze
      uri = dia_warehouse + "&postal_code=" + code.to_s
      begin
        data = XmlSimple.xml_in(open(uri)) 
        data['entry'][0]['district'].nil? ? nil : data['entry'][0]['district'][0].strip
      rescue REXML::ParseException
        nil
      end
    end
    @codes = @zips.collect {|z| z.zip}
    @events += @calendar.public_events.find(:all, :conditions => ["postal_code IN (?)", @codes])
    @events.uniq!
    @events.each {|e| e.instance_variable_set(:@distance_from_search, e.respond_to?(:distance) ? e.distance.to_f : @zips.find {|z| z.zip == e.postal_code}.distance.to_f) }
    @events = @events.sort_by {|e| e.instance_variable_get(:@distance_from_search)}
    render :layout => false
  end

  def by_state
    params[:state] ||= params[:id]
    if request.xhr?
      # this looks weird because by_state was traditionally not called directly, now it's being called by the map using xhr.  should refactor this.
      @events = @calendar.public_events.find(:all, :conditions => ["state = ?", params[:id]])
      render :partial => 'report', :collection => @events and return
    end
    @search_area = params[:state]
    if params[:category] and not params[:category] == "all"
      @events = @calendar.public_events.find(:all, :conditions => ["state = ? AND category_id = ?", params[:state], params[:category]])
    else
      @events = @calendar.public_events.find(:all, :conditions => ["state = ?", params[:state]])
    end
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

  private
    def is_partner(form)
      File.exist?("themes/#{current_theme}/views/events/partners/#{form}")
    end

    def is_signup(form)
      File.exist?("themes/#{current_theme}/views/signup/#{form}.rhtml")
    end
end
