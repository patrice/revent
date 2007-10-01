class Admin::InvitesController < AdminController
  def index
    @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites], :limit => 10)
    @events = @calendar.events.find(:all, :select => "name, id")
    @select_events = []
    @events.each {|e| @select_events << [e.name, e.id]}
    
  end
  
  def edit
    @politician = Politician.find(params[:id])
    @politician.update_attributes(params[:politician]) if request.post?
  end
  
  def confirm
    @politician = Politician.find(params[:id])
    r = @politician.rsvps.build(:event_id => params[:event])
    r.save
    index and render :action => 'index'
  end
  
  def unconfirm
    @politician = Politician.find(params[:id])
    @rsvp = Rsvp.find(params[:rsvp])
    @politician.rsvps.delete(@rsvp)
    index and render :action => 'index'
  end
  
end
