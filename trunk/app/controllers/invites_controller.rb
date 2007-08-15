class InvitesController < ApplicationController
  before_filter :get_event
  INVITE_TYPES = ["call", "email", "letter"]

  def list
    @politicians = Politician.find(:all, :conditions => ["district_id = ?", @event.district_id])
    render :action => 'list'
  end

  def show
    @politician = Politician.find(params[:politician_id])
  end

  def create
    PoliticianInvite.new do |i|
      i.user_id = @current_user.id if logged_in?
      i.politician_id = params[:politician_id]
      i.event_id = params[:id]
      #i.invite_type = params[:invite_type]
      i.save
    end
  end
  
protected
  def get_event
    @event = @calendar.events.find(params[:id])
  end
end
