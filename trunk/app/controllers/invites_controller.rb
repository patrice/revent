class InvitesController < ApplicationController
  before_filter :set_event
  INVITE_TYPES = ["Call", "Email", "Send A Letter"]

  def list
    @politicians = Politician.find(:all, :conditions => ["district_id = ?", @event.district_id])
    @invite_types = INVITE_TYPES
    render :action => 'list'
  end

  def show
    # avoid db hit here, should get @politician from @politicians
    @politician = Politician.find(params[:politician_id])
  end

  def create
    PoliticianInvite.new do |i|
      i.user_id = @current_user.id if logged_in?
      i.politician_id = params[:politician_id]
      i.event_id = params[:id]
      # i.invite_type = params[:invite_type]
      i.save
    end
    redirect_to :action => 'thank_you', :id => @event, :politician_id => params[:politician_id]
  end
  
  def thank_you
    @politician = Politician.find(params[:politician_id])
  end
  
protected
  def set_event
    @event = @calendar.events.find(params[:id])
  end
end
