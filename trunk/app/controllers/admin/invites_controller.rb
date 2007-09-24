class Admin::InvitesController < AdminController
  def index
    @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites], :limit => 400)
    @events = @calendar.events.find(:all, :select => "name")
  end
  
  def edit
    @politician = Politician.find(params[:id])
    if request.post?
      @politician.update_attributes(params[:politician])
    end
  end
  
  def invite
    p = Politician.find(params[:id])
  end
  
  def confirm
    @politician = Politician.find(params[:id])
    
  end
  
end
