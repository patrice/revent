class Admin::ReportsController < AdminController 
  def index
    redirect_to :action => :list unless @calendar.nil?
    @calendars = Site.current.calendars
  end

  def list
    if params[:id] == 'unpublished'
      @reports = @calendar.reports.paginate(:all, :per_page => 20, :page => params[:page])
    else
      @reports = @calendar.published_reports.paginate(:all, :per_page => 20, :page => params[:page])
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
          page.alert "Report has been deleted"
        end
      end
    end
  end

  def publish
    @report = Report.publish(params[:id])
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
    respond_to do |wants|
      wants.html { redirect_to :action => 'list' }
      wants.js do
        render :update do |page|
          page.alert "Report has been unpublished"
        end
      end
    end
  end


end
