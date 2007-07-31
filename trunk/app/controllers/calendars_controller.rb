class CalendarsController < ApplicationController
  before_filter :find_calendar, :only => [:index]
  def index
    return show if @calendar
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :action => :list }

  def list
    @calendars = @site.calendars
  end

  def show
    @calendar ||= Calendar.find(params[:id], :include => :events)
    @events = @calendar.events
    render :action => 'show'
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = @site.calendars.build(params[:calendar])
    if @calendar.save
      flash[:notice] = 'Calendar was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @calendar = Calendar.find(params[:id])
  end

  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update_attributes(params[:calendar])
      flash[:notice] = 'Calendar was successfully updated.'
      redirect_to :action => 'show', :id => @calendar.to_param
    else
      render :action => 'edit'
    end
  end

  def destroy
    Calendar.find(params[:id]).destroy
    flash[:notice] = 'Calendar was successfully destroyed.'    
    redirect_to :action => 'index'
  end

  def events
    @calendar = Calendar.find(params[:id])
  end

  protected

    def find_calendar
      @calendar = @site.calendars.find_by_permalink(params[:permalink]) if params[:permalink]
      @calendar ||= @site.calendars.find(params[:id]) if params[:id]
      @calendar ||= @site.calendars.current
    end
end
