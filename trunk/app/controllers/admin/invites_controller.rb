class Admin::InvitesController < AdminController
  def index
    @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites])
  end
end
