class Account::EventsController < ApplicationController
  session :disabled => false
  before_filter :login_required

  def index
    @hosting = current_user.events
    @attending = current_user.events_attending
  end

  def show
    @blog = Blog.new(:event => @event)
  end

  def update
    @event.update_attributes(params[:event].merge(:calendar_id => 1))
    @event.save!
    flash[:notice] = 'Event updated'
    redirect_to :action => 'show', :id => @event
  end

  def invite
    UserMailer.deliver_invite(@event, params[:invite])
    flash[:notice] = 'Invites delivered'
    redirect_to :action => 'show', :id => @event
  end

  protected
  def authorized?
    return true if %w(index).include?(action_name)
    @event = Event.find(params[:id])
    return true if current_user.events.include?(@event)
  end
end
