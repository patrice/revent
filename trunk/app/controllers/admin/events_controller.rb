class Admin::EventsController < AdminController
  def index
    @calendar = Calendar.find_by_permalink(params[:permalink])
    @events_pages, @events = paginate(:events, :conditions => ['calendar_id = ?', @calendar.id], :order => 'name')
  end
  
  def destroy
    e = Event.find(params[:id])
    e.destroy
    # also need to destroy event in DIA
    flash.now[:notice] = e.name + " has been destroyed"
    redirect_to url_for(:action => 'index')
  end
  
  def search
    @event = Event.find_by_name(params[:name])
  end
end
