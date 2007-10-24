class Admin::EventsController < AdminController
  def index
    @calendar = Calendar.find_by_permalink(params[:permalink])
    @events_pages, @events = paginate(:events, :conditions => ['calendar_id = ?', @calendar.id], :order => 'name', :per_page => 50)
  end
  
  def destroy
    e = Event.find(params[:id])
    e.destroy
    # also need to destroy event in DIA
    flash[:notice] = e.name + " has been destroyed"
    redirect_to :action => 'index'
  end
  
  def search
    @events = []
    string = []
    crit = []
    %w(name state city).each do |s|
      string << s + " like ?"
      crit << params[s] + "%"
    end
    event_criteria = [string.join(' AND '), crit].flatten
    @events = @calendar.events.find(:all, :conditions => event_criteria)
    
    if @events.empty?
      flash[:notice] = "Could not find that event."
      redirect_to :action => 'index'
    end
  end

  def nomap
    @events = @calendar.events.find(:all, :conditions => "latitude = 0 or latitude IS NULL or longitude = 0 or longitude IS NULL")
    render :action => 'search'
  end
  
  def export
    @events = @calendar.events.find(:all, :include => :host)
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Event Name", "City", "State", "Postal_Code", "Organizer", "Email", "Phone"]
      @events.each do |event|
        csv << [event.name, event.city, event.state, event.postal_code, event.host.full_name, event.host.email, event.host.phone]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "events.csv")
  end
end
