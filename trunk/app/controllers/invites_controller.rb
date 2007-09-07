class InvitesController < ApplicationController
  before_filter :set_event
  
  def index
    @politicians = []
    # get representative for this event's district
    @politicians << Politician.find_by_district(@event.district)
    # get both senators for this event's state 
    @politicians << Politician.find_by_district(@event.state + "1")
    @politicians << Politician.find_by_district(@event.state + "2")
  end

  def write
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end
  
  def call
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end

  def email
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end

  def create
    @user = User.find_or_initialize_by_email(params[:user][:email]) # or current_user
    @user.attributes = params[:user]
    unless @user.crypted_password || (@user.password && @user.password_confirmation)
      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      @user.password = @user.password_confirmation = password
    end
    @user.save
    @invite = {}
    @invite[:user_id] = @user.id
    @invite[:politician_id] = params[:politician_id]
    @invite[:event_id] = @event.id
    @invite[:invite_type] = params[:invite_type]    
    PoliticianInvite.create(@invite)
    redirect_to url_for(:action => 'thank_you', :politician_id => params[:politician_id])
  end
    
  def thank_you
    @politician = Politician.find(params[:politician_id])
  end
  
protected
  def set_event
    @event = @calendar.events.find(params[:id])
  end
end
