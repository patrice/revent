class Admin::InvitesController < AdminController
  def index
    @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites])
    @events = @calendar.events.find(:all, :select => "name, id", :order => "name")
    @select_events = []
    @events.each {|e| @select_events << [e.name, e.id]}
  end
  
  def edit
    @politician = Politician.find(params[:id])
    if request.post?
      @politician.update_attributes(params[:politician]) 
      redirect_to :action => 'index'
    end
  end
  
  def confirm
    @politician = Politician.find(params[:id])
    r = @politician.rsvps.build(:event_id => params[:event])
    r.save
    redirect_to :action => 'index'
  end
  
  def unconfirm
    @politician = Politician.find(params[:id])
    @rsvp = Rsvp.find(params[:rsvp])
    @politician.rsvps.delete(@rsvp)
    redirect_to :action => 'index'
  end
  
end
