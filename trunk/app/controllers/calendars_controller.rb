class CalendarsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @calendar_pages, @calendars = paginate :calendars, :per_page => 10
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(params[:calendar])
    if @calendar.save
      flash[:notice] = 'Calendar was successfully created.'
      redirect_to :action => 'list'
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
      redirect_to :action => 'show', :id => @calendar
    else
      render :action => 'edit'
    end
  end

  def destroy
    Calendar.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def events
    @calendar = Calendar.find(params[:id])
  end
end
