class EventGroupsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_group_pages, @event_groups = paginate :event_groups, :per_page => 10
  end

  def show
    @event_group = EventGroup.find(params[:id])
  end

  def new
    @event_group = EventGroup.new
  end

  def create
    @event_group = EventGroup.new(params[:event_group])
    if @event_group.save
      flash[:notice] = 'EventGroup was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event_group = EventGroup.find(params[:id])
  end

  def update
    @event_group = EventGroup.find(params[:id])
    if @event_group.update_attributes(params[:event_group])
      flash[:notice] = 'EventGroup was successfully updated.'
      redirect_to :action => 'show', :id => @event_group
    else
      render :action => 'edit'
    end
  end

  def destroy
    EventGroup.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def events
    @event_group = EventGroup.find(params[:id])
  end
end
