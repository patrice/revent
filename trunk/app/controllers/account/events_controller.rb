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
    expire_page :controller => '/events', :action => 'show', :id => @event
    redirect_to :action => 'show', :id => @event
  end

  def invite
    UserMailer.deliver_invite(current_user.Email, @event, params[:invite])
    flash[:notice] = 'Invites delivered'
    redirect_to :action => 'show', :id => @event
  end

  def message
    UserMailer.deliver_message(current_user.Email, @event, params[:message])
    flash[:notice] = 'Email delivered'
    redirect_to :action => 'show', :id => @event
  end

  def remove
    api = DIA_API_Simple.new API_OPTS
    records = api.get 'supporter_event', 'where' => "supporter_KEY=#{current_user.key}"
    rec = records.detect {|r| r['event_KEY'] == @event.dia_event.key}
    api.deleteKey 'supporter_event', rec['key'] unless rec.nil? || rec.empty?
    current_user.events_attending=nil
    redirect_to :action => 'index'
  end

  def attendees
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Email", "First_Name", "Last_Name", "Phone"]
      @event.dia_event.attendees.each do |sup|
        csv << [sup.Email, sup.First_Name, sup.Last_Name, sup.Phone]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "event_#{@event.id}_attendees.csv")
  end

  protected
  def authorized?
    return true if %w(index).include?(action_name)
    @event = Event.find(params[:id])
    if %w(remove).include?(action_name)
      return true if current_user.events_attending.include?(@event)
    end
    return true if current_user.events.include?(@event)
    false
  end
end
