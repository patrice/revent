class ReportsController < ApplicationController
  ADMIN_METHODS = [:list, :edit, :update, :destroy, :publish, :unpublish]
  session :disabled => false, :only => ADMIN_METHODS
  before_filter :login_required, :only => ADMIN_METHODS
  access_control ADMIN_METHODS => 'admin'

  def index
    @calendar = Calendar.find(:first)
    @reports = Report.find_published(:all, :include => [ :event, :attachments ], :conditions => ['reports.position = ?', 1], :order => "events.state, events.city")
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @report_pages, @reports = paginate :reports, :select => "reports.*, reports.status = '#{Report::PUBLISHED}' as published", :joins => "LEFT OUTER JOIN events ON events.id=event_id", :order => "published DESC, state, city", :per_page => 10
  end

  def show
    method = logged_in? && current_user.admin? ? 'find' : 'find_published'
    @report = Report.send(method,params[:id], :include => :attachments)
  end

  def new
    @report = Report.new
    if params[:service] && params[:service_foreign_key]
      @report.event = Event.find_or_import_by_service_foreign_key(params[:service_foreign_key])
    end
    @user = logged_in? ? current_user : User.new
  end

  def create
    @report = Report.new(params[:report])
    @attachments = []
    params[:attachment].each do |index, file|
      @attachments << @report.attachments.build({:caption => params[:caption][index]}.merge(:uploaded_data => file)) unless file.blank?
    end if params[:attachment]
    Attachment.transaction { @attachments.each &:save! }

    if @report.save
      flash[:notice] = 'Report was successfully created.'
      redirect_to :action => 'list'
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
      flash[:notice] = 'Report was successfully updated.'
      redirect_to :action => 'show', :id => @report
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report = Report.find(params[:id]).destroy
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
    @report = Report.find(params[:id])
    @report.publish
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
    @report = Report.find(params[:id])
    @report.unpublish
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
    @report = Report.find(params[:id])
    render :layout=>false
  end
    
end
