class ReportsController < ApplicationController

  caches_page :show, :index, :flashmap, :list, :new, :press, :video, :lightbox
  cache_sweeper :report_sweeper, :only => [ :create, :update, :destroy, :publish, :unpublish ]
  verify :method => :post, :only => :create, :redirect_to => {:action => 'index'}

  def index
    @events = @calendar.public_events.find(:all, :include => :reports, :conditions => ["latitude <> 0 AND longitude <> 0 AND country_code = ?", Event::COUNTRY_CODE_USA])
  end

  def call
    @event = @calendar.events.find params[:id]
    @rep = Politician.find_by_district @event.district
    @senators = Politician.find_all_by_state_and_district_type @event.state, 'FS'
  end

  def video
    if params[:tag]
      tag = Tag.find_by_name params[:tag]
      @embeds = tag.embeds.find(:all, :include => {:report => :event}, :conditions => "events.calendar_id = #{@calendar.id}")
      @reports = @embeds.collect {|e| e.report}.uniq
    else
      @reports = @calendar.published_reports.find(:all, :conditions => "embeds.id", :include => [:event, :embeds])
    end
  end

  def photos
    if params[:tag]
      tag = Tag.find_by_name params[:tag]
      @photos = tag.attachments.find(:all, :include => {:report => :event}, :conditions => "events.calendar_id = #{@calendar.id}")
    else
      @photos = @calendar.published_reports.find(:all, :include => [:attachments, :event], :conditions => "attachments.id").collect {|r| r.attachments}.flatten
    end
  end

  def press
    @press_links = @calendar.published_reports.find(:all, :include => [:event, :press_links], :conditions => "press_links.id").collect {|r| r.press_links}.flatten
  end

  def flashmap
    # all events should have lat/lng or fallback lat/lng; remove ones that don't just in case
    @events = @calendar.events.find(:all, :conditions => ["(latitude <> 0 AND longitude <> 0 AND country_code = ?)", Event::COUNTRY_CODE_USA])
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end

  def scrolling_photos 
    # not quite ready to scroll dynamic content
    redirect_to :action => 'index' and return
    @reports = @calendar.published_reports.find(:all, :include => [:attachments], :conditions => "attachments.id AND attachments.content_type = 'image/jpeg'", :limit => 5)
    #@reports = @calendar.published_reports.find(:all, :include => :attachments, :conditions => "events.id IN (3144, 3155, 3215, 3178, 3181, 3136) AND attachments.primary = 1")
    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

  def rss
    @reports = @calendar.published_reports(:all, :order => "updated_at DESC")
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end

  def list
    @events = @calendar.public_events.paginate(:all, :include => {:reports => :attachments}, 
      :conditions => "reports.id AND reports.status = '#{Report::PUBLISHED}'", :order => "reports.id", :page => params[:page], :per_page => 20)
    @reports = @events.collect {|e| e.reports.first}
    # temporary fix to get everythingscool layout to load here
    if File.exists?("#{Theme.path_to_theme(Site.current.theme || @calendar.theme)}/layouts/reports.rhtml")
      render(:layout => "../../themes/#{Site.current.theme || @calendar.theme}/layouts/reports")
    end    
  end

  def international 
    @country_a3 = params[:id] || "all"
    @country_code = CountryCodes.find_by_a3(@country_a3)[:numeric] || "all"
    if @country_code == "all"
      @events = @calendar.public_events.paginate(:all, :include => {:reports => :attachments}, 
        :conditions => "reports.id AND reports.status = '#{Report::PUBLISHED}' AND country_code <> '#{Event::COUNTRY_CODE_USA}'", :order => "reports.id", :page => params[:page], :per_page => 20)
    else
      @events = @calendar.public_events.paginate(:all, :include => {:reports => :attachments}, 
        :conditions => ["reports.id AND reports.status = '#{Report::PUBLISHED}' AND country_code = ?", @country_code], :order => "reports.id", :page => params[:page], :per_page => 20)
    end
    @reports = @events.collect {|e| e.reports.first}
  end
 
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def show
    @event = @calendar.events.find(params[:event_id], :include => {:reports => :attachments}, :order => 'reports.position')
    @attending_politicians = @event.attending_politicians.map {|p| p.parent || p}.uniq
    @supporting_politicians = @event.supporting_politicians.map {|p| p.parent || p}.uniq
  end

  include ActionView::Helpers::TextHelper
  def new 
    @report = Report.new(:event_id => params[:id])
    if params[:service] && params[:service_foreign_key]
      @report.event = Event.find_or_import_by_service_foreign_key(params[:service_foreign_key])
    end
  end

  def create
    #redirect_to(:action => :index) and return unless params[:user]
    @report = Report.new(params[:report])
    @user = User.find_or_initialize_by_site_id_and_email(Site.current.id, params[:user][:email]) # or current_user
    @user.attributes = params[:user].reject {|k,v| [:password, :password_confirmation].include?(k.to_sym)}
    unless @user.crypted_password || (@user.password && @user.password_confirmation)
      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      @user.password = @user.password_confirmation = password
    end
    params[:press_links].reject {|link| link[:url].empty? || link[:text].empty?}.each do |link|
      @report.press_links.build(link)
    end
    Tag #why not?
    @attachments = params[:attachments].reject {|i,a| a[:uploaded_data].blank?}.collect do |i,a|
      tags = a.delete(:tags).join(' ') if a[:tags]
      attachment = Attachment.new(a)
      attachment.tag_depot = tags
      attachment
    end

    if @user.valid? && @report.valid? && @attachments.all? {|a| a.valid?}
      @user.deferred = true
      @user.save
      @report.user_id = @user.id
      @report.save
      @attachments.each {|a| a.report_id = @report.id}
      params[:embeds].reject {|i,embed| embed[:html].empty?}.each do |i,embed|
        tags = embed.delete(:tags) if embed[:tags]
        e = @report.embeds.create embed
        e.tags = tags if tags
      end
      @event = @report.event
      begin
#        require 'starling_client'
        require 'starling'
        queue = Starling.new 'localhost:22122'
        r = {:remote_ip => request.remote_ip, :user_agent => request.user_agent, :referer => request.referer}
        attachments = @attachments.collect {|a| [a, a.temp_data]}
        attachments.each {|a| a[0].clear_temp_paths}
        queue.set 'reports', {:report => @report, :attachments => attachments, :request => r, :site => Site.current, 
              :flickr_tags => @event.calendar.flickr_tags(@event.id), :flickr_photoset => @event.calendar.flickr_photoset}
        queue.set 'users', {:user => @user, :site => Site.current}
      rescue Exception => e
        attachments.each do |a| 
          a[0].temp_data = a[1]
          a[0].save
          a[0].tags = a[0].tag_depot  if a[0].tag_depot
        end
        @report.attachments = attachments.collect {|a| a[0]}
        @report.embeds.each {|e| e.tags = e.tag_depot if e.tag_depot }
        require 'upload_to_flickr'
        upload_images_to_flickr(@report.attachments, 
              :site_id => Site.current, 
              :title => "#{@report.event.name} - #{@report.event.city_state}",
              :flickr_tags =>  @event.calendar.flickr_tags(@event.id), 
              :flickr_photoset => @event.calendar.flickr_photoset)
        @report.check_akismet(r)
        @user.deferred = false
        @user.sync_to_democracy_in_action
      end
      flash[:notice] = 'Report was successfully created.'
      index
      render :permalink => @calendar.permalink, :action => 'index'
    else
      render :permalink => @calendar.permalink, :action => 'new'
    end
  rescue NoMethodError
    redirect_to :permalink => @calendar.permalink, :action => 'index'
  end

  def lightbox
    @parent = Attachment.find(params[:id])
    return unless @parent
    @attachment = @parent.thumbnails.find_by_thumbnail('lightbox')
    render :layout => false
  end

  def share 
    @event = Event.find(params[:id])
    render :layout => false
  end

  def widget
    if params[:id]
      @report = Report.find_published(params[:id], :include => :attachments)
      @image = @report.attachments.first
    else
#      @image = Attachment.find(:first, :joins => 'LEFT OUTER JOIN reports ON attachments.report_id = reports.id', :conditions => ['report_id AND reports.status = ?', Report::PUBLISHED], :order => 'RAND()')
      @image = Attachment.find(:first, :include => [:report => :event], :conditions => ['report_id AND reports.status = ?', Report::PUBLISHED], :order => 'RAND()')
      @report = @image.report
    end
    render :layout => false
  end

  def do_zip_search
    @zip = ZipCode.find_by_zip(params[:zip])
#    flash.now[:notice] = "Could not locate that zip code" and return unless @zip
    @search_results_message = "Sorry, we don't have that zip code in our database, try a different one from near by." and return unless @zip
    @zips = @zip.find_objects_within_radius(100) do |min_lat, min_lon, max_lat, max_lon|
      ZipCode.find(:all, 
                   :conditions => [ "(latitude > ? AND longitude > ? AND latitude < ? AND longitude < ? ) ", 
                        min_lat, 
                        min_lon, 
                        max_lat, 
                        max_lon])
    end
    @events = @calendar.public_events.paginate(:all, :include => {:reports => :attachments}, :conditions => ["reports.id AND reports.status = '#{Report::PUBLISHED}' AND events.postal_code IN (?)", @zips.collect {|z| z.zip}], :order => "reports.id DESC", :page => params[:page], :per_page => 20)
    @reports = @events.collect {|e| e.reports.first}
    @codes = @zips.collect {|z| z.zip}
#    @reports = @reports.sort_by {|r| @codes.index(r.event.postal_code)}
    @reports.each {|r| r.instance_variable_set(:@distance_from_search, @zips.find {|z| z.zip == r.event.postal_code}.distance_to_search_zip) }
    @search_results_message = "Showing reports within 100 miles of #{@zip.zip}"
    @search_params = {:zip => @zip.zip}
  end

  def do_state_search
    @events = @calendar.public_events.paginate(:all, :include => {:reports => :attachments}, :conditions => ["reports.id AND reports.status = '#{Report::PUBLISHED}' AND events.state = ?", params[:state]], :order => "events.state, events.city", :page => params[:page], :per_page => 20)
    @reports = @events.collect {|e| e.reports.first}

    @search_results_message = "Showing reports in #{params[:state]}"
    @search_params = {:state => params[:state]}
  end

  def search
    redirect_to :action => 'index' and return unless params[:zip] || params[:state]
    if params[:zip] && !params[:zip].empty?
      do_zip_search
    elsif params[:state] && !params[:state].empty?
      do_state_search
    end
    unless @reports
      list
      render :action => 'list' and return
    end
    render :action => 'list'
  end

  def slideshow
    if @flickr_user_id = Site.current.flickr_user_id
      @slideshow_url = "http://www.flickr.com/slideShow/index.gne?user_id=#{@flickr_user_id}"
      @slideshow_url += "&tags=#{@calendar.flickr_tag}#{params[:id]}" if @calendar.flickr_tags
    end
  end

  def featured
    if params[:id]
      @reports = @calendar.featured_reports.find(:all, :conditions => ["events.state = ?", params[:id]], :include => :event, :limit => 7, :order => 'reports.created_at DESC')
    else
      @reports = @calendar.featured_reports.find(:all, :include => :event, :limit => 7, :order => 'reports.created_at DESC')
    end
    render :layout => false
  end
end
