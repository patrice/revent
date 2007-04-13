class ReportsController < ApplicationController
  ADMIN_METHODS = [:edit, :update, :destroy, :publish, :unpublish]
  session :disabled => false, :only => ADMIN_METHODS
  before_filter :login_required, :only => ADMIN_METHODS
  access_control ADMIN_METHODS => 'admin'

  before_filter do |controller|
    if controller.params[:host] == 'truemajority' && controller.action_name == 'index' &&
      !(controller.params[:page])
      controller.page_cache_directory = File.join(RAILS_ROOT,"public","truemajority")
    else
      controller.page_cache_directory = File.join(RAILS_ROOT,"public")
    end
  end

  caches_page :show, :index, :flashmap, :list

  def index
    @calendar = Calendar.find(1)
    @events = @calendar.events
  end

  def video
    @reports = Report.find(:all, :conditions => "embed <> ''")
  end

  def press
    @press_links = PressLink.find(:all)
  end

  def flashmap
    @events = Event.find(:all, :conditions => ["postal_code != ?", 0], :joins => "INNER JOIN zip_codes ON zip_codes.zip = postal_code", :select => "events.*, zip_codes.latitude as zip_latitude, zip_codes.longitude as zip_longitude")
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end

  def list 
    @calendar = Calendar.find(:first)
    @report_pages = Paginator.new self, Report.count_published, 30, params[:page]
    @reports = Report.find_published(:all, :include => [ :event, :attachments ], :conditions => ['reports.position = ?', 1], :order => "events.state, events.city", :limit  =>  @report_pages.items_per_page, :offset =>  @report_pages.current.offset)
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def old_list
    @report_pages, @reports = paginate :reports, :select => "reports.*, reports.status = '#{Report::PUBLISHED}' as published", :joins => "LEFT OUTER JOIN events ON events.id=event_id", :order => "published DESC, state, city", :per_page => 10
  end

  def show
    @event = Event.find(params[:event_id], :include => {:reports => :attachments})
  end

  def new
    @report = Report.new(:event_id => params[:id])
    if params[:service] && params[:service_foreign_key]
      @report.event = Event.find_or_import_by_service_foreign_key(params[:service_foreign_key])
    end
  end

  def create
    @report = Report.new(params[:report])
    params[:press_links].reject {|link| link[:url].empty? || link[:text].empty?}.each do |link|
      @report.press_links.build(link)
    end
    params[:attachments].reject {|att| att[:uploaded_data].blank?}.each do |att|
      @report.attachments.build(att)
    end

    if @report.save
      @report.attachments.each do |attachment|
        @@flickr ||= Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr',RAILS_ENV,'token.cache'))
        @@flickr.photos.upload.upload_file_async(attachment.full_filename, "#{@report.event.name} - #{@report.event.city}, #{@report.event.state}", attachment.caption, ["stepitup", "stepitup#{@report.event.id}"])
      end
      expire_page_caches(@report)
      flash[:notice] = 'Report was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      expire_page_caches(@report)
      flash[:notice] = 'Report was successfully updated.'
      redirect_to :action => 'show', :id => @report
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report = Report.find(params[:id]).destroy
    expire_page_caches(@report)
    respond_to do |wants|
      wants.html { redirect_to :action => 'list' }
      wants.js do
        render :update do |page|
          page.remove "report_#{@report.id}"
        end
      end
    end
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

  def publish
    @report = Report.publish(params[:id])
    expire_page_caches(@report)
    respond_to do |wants|
      wants.html { redirect_to :action => 'show', :id => @report }
      wants.js do
        render :update do |page|
          page.alert "Report has been published"
        end
      end
    end
  end

  def unpublish
    @report = Report.unpublish(params[:id])
    expire_page_caches(@report)
    respond_to do |wants|
      wants.html { redirect_to :action => 'list' }
      wants.js do
        render :update do |page|
          page.alert "Report has been unpublished"
        end
      end
    end
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
    @search_results_message = "Sorry, we don't have that zip code in our database, try a different one from near by."
    @zips = @zip.find_objects_within_radius(100) do |min_lat, min_lon, max_lat, max_lon|
      ZipCode.find(:all, 
                   :conditions => [ "(latitude > ? AND longitude > ? AND latitude < ? AND longitude < ? ) ", 
                        min_lat, 
                        min_lon, 
                        max_lat, 
                        max_lon])
    end
    @report_pages = Paginator.new self, Report.count_published(:include => :event, :conditions => ["reports.position = ? AND events.postal_code IN (?)", 1, @zips.collect {|z| z.zip}]), 30, params[:page]
    @reports = Report.find_published(:all, :include => [ :event, :attachments ], :conditions => ["reports.position = ? AND events.postal_code IN (?)", 1, @zips.collect {|z| z.zip}], :order => "events.state, events.city", :limit => @report_pages.items_per_page, :offset => @report_pages.current.offset)
    @search_results_message = "Showing reports within 100 miles of #{@zip.zip}"
    @search_params = {:zip => @zip.zip}
  end
  def do_state_search
    @report_pages = Paginator.new self, Report.count_published(:include => :event, :conditions => ["reports.position = ? AND events.state = ?", 1, params[:state]]), 30, params[:page]
    @reports = Report.find_published(:all, :include => [ :event, :attachments ], :conditions => ["reports.position = ? AND events.state = ?", 1, params[:state]], :order => "events.state, events.city", :limit => @report_pages.items_per_page, :offset => @report_pages.current.offset)
    @search_results_message = "Showing reports in #{params[:state]}"
    @search_params = {:state => params[:state]}
  end

  def search
    redirect_to :action => 'index' and return unless params[:zip] || params[:state]
    if params[:zip]
      do_zip_search
    elsif params[:state]
      do_state_search
    end
    unless @reports
      list
      render :action => 'list' and return
    end
    @calendar = Calendar.find(:first)
    render :action => 'list'
  end

  protected
    def expire_page_caches(report = nil)
      expire_page :action => "show", :id => report
      expire_page :controller => "events", :action => "show", :id => report.event
      FileUtils.rm_rf(File.join(RAILS_ROOT,'public','reports','page')) rescue Errno::ENOENT
      FileUtils.rm(File.join(RAILS_ROOT,'public','index.html')) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Caches fully swept.")
    end
end
