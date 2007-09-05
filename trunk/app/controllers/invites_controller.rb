class InvitesController < ApplicationController
  before_filter :login_required, :only => [ :call, :email, :write ]
  before_filter :set_event

  def list
    @politicians = Politician.find_by_district_id(@event.district_id)
    render :action => 'list'
  end

  def show
    # avoid db hit here, should get @politician from @politicians
    @politician = Politician.find(params[:politician_id])
    # logged_in? ? (@current_user.first_name.to_s + @current_user.last_name.to_s)  : "<Your Name>"  
  end

  def create
    PoliticianInvite.new do |i|
      i.user_id = current_user.id if logged_in?
      i.politician_id = params[:politician_id]
      i.event_id = params[:id]
      i.invite_type = params[:invite_type]
      i.save
    end
    redirect_to :action => 'thank_you', :id => @event, :politician_id => params[:politician_id]
  end
  
  def email
    show
  end
  
  def call
    show
  end
  
  def write
    show
    render :action => 'show'
  end
  
  def thank_you
    @politician = Politician.find(params[:politician_id])
  end
  
protected
  def set_event
    @event = @calendar.events.find(params[:id])
  end
end
