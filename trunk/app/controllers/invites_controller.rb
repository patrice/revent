=begin
- take first district if multiple districts
- create DIA campaign for all possible scenarios 
- every event will have 3 campaigns; create as events are created
- track number of invites
- js postback/poll

letter/call => popup {script, form: name, email, button "I mailed this letter"}
email => DIA campaign

track number of invites
=end

class InvitesController < ApplicationController
  before_filter :login_required, :only => [ :call, :email, :write ]
  before_filter :set_event

  def index
    @politicians = []
    @politicians << Politician.find_by_district(@event.district)
    @politicians << Politician.find_by_district(@event.state + "1")
    @politicians << Politician.find_by_district(@event.state + "2")
  end

  def show
    @politician = Politician.find(params[:politician_id])
    # logged_in? ? (@current_user.first_name.to_s + @current_user.last_name.to_s)  : "<Your Name>"  
  end

  def create
    user = User.find_by_email(params[:user][:email])
    user = User.create(params[:user]) if user.nil?
    invite = {}
    invite[:user_id] = user.id
    invite[:politician_id] = params[:politician_id]
    invite[:event_id] = @event.id
    invite[:invite_type] = params[:invite_type]    
    PoliticianInvite.create(invite)
    redirect_to :action => 'thank_you', :id => @event, :politician_id => params[:politician_id]
  end
  
  def letter
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end
  
  def email
    show
  end
  
  def call
=begin
  if no ph, list website, put form to enter phone
=end    
    
    show
  end
  
  def thank_you
    @politician = Politician.find(params[:politician_id])
  end
  
protected
  def set_event
    @event = @calendar.events.find(params[:id])
  end
end
