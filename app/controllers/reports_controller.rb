class ReportsController < ApplicationController
  ADMIN_METHODS = [:list, :edit, :update, :destroy, :publish, :unpublish]
  session :disabled => false, :only => ADMIN_METHODS
  before_filter :login_required, :only => ADMIN_METHODS
  access_control ADMIN_METHODS => 'admin'

  caches_page :show, :index

  def index
    @calendar = Calendar.find(:first)
    @report_pages = Paginator.new self, Report.count_published, 30, params[:page]
    @reports = Report.find_published(:all, :include => [ :event, :attachments ], :conditions => ['reports.position = ?', 1], :order => "events.state, events.city", :limit  =>  @report_pages.items_per_page, :offset =>  @report_pages.current.offset)
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @report_pages, @reports = paginate :reports, :select => "reports.*, reports.status = '#{Report::PUBLISHED}' as published", :joins => "LEFT OUTER JOIN events ON events.id=event_id", :order => "published DESC, state, city", :per_page => 10
  end

  def show
    method = logged_in? && current_user.admin? ? 'find' : 'find_published'
    @report = Report.send(method,params[:id], :include => [:event, :attachments])
  end

  def new
    @report = Report.new
    if params[:service] && params[:service_foreign_key]
      @report.event = Event.find_or_import_by_service_foreign_key(params[:service_foreign_key])
    end
  end

  def create
    @report = Report.new(params[:report])
    @attachments = []
    params[:attachment].each do |index, file|
      @attachments << @report.attachments.build({:caption => params[:caption][index]}.merge(:uploaded_data => file)) unless file.blank?
    end if params[:attachment]
    begin
      Attachment.transaction do 
        @attachments.each &:save! 
      end
    rescue ActiveRecord::RecordInvalid
    end

    if @report.save
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
    @report = Report.find_published(params[:id] || :first,:order=>'RAND()')
    render :layout=>false
  end

  def search
    @zip = ZipCode.find_by_zip(params[:zip])
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
    @calendar = Calendar.find(:first)
    @search_results_message = "Showing reports within 100 miles of #{@zip.zip}"
    @search_params = {:zip => @zip.zip}
    render :action => 'index'
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
