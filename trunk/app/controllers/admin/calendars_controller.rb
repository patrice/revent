class Admin::CalendarsController < AdminController
  skip_before_filter :set_calendar
  def index
    if Site.current.calendars.count > 1
      return show if @calendar
      @calendars = Site.current.calendars
    else
      redirect_to :controller => 'admin/events', :permalink => Site.current.calendars.current.permalink
    end
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ]

  # /admin/calendars/show?id=
  def show
    @calendar = Calendar.find(params[:id])
    @events = @calendar.events
    render :action => 'show'
  end

  # /admin/calendars/new
  def new
    @calendar = Calendar.new
  end

  # /admin/calendars/create
  def create
    @calendar = @site.calendars.build(params[:calendar])
    if @calendar.save
      flash[:notice] = 'Calendar was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  # /admin/calendars/edit?id=
  def edit
    @calendar = Calendar.find(params[:id])
  end

  # /admin/calendars/update?id=
  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update_attributes(params[:calendar])
      flash[:notice] = 'Calendar was successfully updated.'
      redirect_to calendars_url
    else
      render :action => 'edit'
    end
  end

  # /admin/calendars/destroy?id=
  def destroy
    Calendar.find(params[:id]).destroy
    flash[:notice] = 'Calendar was successfully destroyed.'    
    redirect_to :action => 'index'
  end

  # /admin/calendars/:id/events
  def events
    @calendar = Calendar.find(params[:id], :include => :events)
    @events = @calendar.events
  end

  protected

    def find_calendar
      @calendar = @site.calendars.find_by_permalink(params[:permalink]) if params[:permalink]
      @calendar ||= @site.calendars.find(params[:id]) if params[:id]
      @calendar ||= @site.calendars.current
    end
end
