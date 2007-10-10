class Account::EventsController < ApplicationController
  session :disabled => false
  before_filter :login_required

  def index
    @hosting = current_user.events
    @attending = current_user.attending
  end

  def show
    extend ActionView::Helpers::TextHelper
    @nearby_events = @calendar.events.find(:all, :origin => @event, :within => 50)
    @nearby_events.reject! { |e| e.id == @event.id }
    @blog = Blog.new(:event => @event)
    city_state = [@event.city, @event.state].join(', ')
    @event.letter_script ||= @calendar.letter_script.gsub('CITY_STATE', city_state) if @calendar.letter_script
    @event.call_script ||= @calendar.call_script.gsub('CITY_STATE', city_state) if @calendar.call_script
    @example = Politician.find_by_district_type_and_state('FS', @event.state)
  end

  def upload
    @event = Event.find(params[:id])
    if !params[:attachment][:uploaded_data].blank? && @event.attachments.create!(params[:attachment])
      flash[:notice] = "Upload successful"
      redirect_to :action => 'show'
    else
      #XXX: to much of this, should move someplace else
      @nearby_events = @calendar.events.find(:all, :origin => @event, :within => 50)
      @nearby_events.reject! { |e| e.id == @event.id }
      flash[:error] = "Upload failed"
      render :action => 'show'
    end
  end

  def update
    redirect_to :action => 'show' and return unless params[:event]
    @event.update_attributes!(params[:event])
    if params[:event][:letter_script] || params[:event][:call_script]
      update_campaign_scripts(@event) if params[:event][:letter_script]
      flash[:notice] = 'Invitation script(s) updated.'
    else
      flash[:notice] = 'Event updated'
    end
    redirect_to :action => 'show', :id => @event
  rescue ActiveRecord::RecordInvalid
    @nearby_events = @calendar.events.find(:all, :origin => @event, :within => 50)
    @nearby_events.reject! { |e| e.id == @event.id }
    render :action => 'show'
  end
  
  def update_campaign_scripts(event)
    objects = DemocracyInActionObject.find(:all, :from => "democracy_in_action_objects as d",
      :conditions => ["d.table = ? AND associated_type = ? AND associated_id = ?", 'campaign', 'Event', event.id])
    objects.each do |o|
      c = DemocracyInActionCampaign.find(o.key)
      c.Suggested_Content = event.letter_script
      c.save
    end
  end  

  def invite
    redirect_to :action => 'show', :id => @event and return unless params[:invite]
    UserMailer.deliver_invite(current_user.email, @event, params[:invite])
    flash[:notice] = 'Invites delivered'
    redirect_to :action => 'show', :id => @event
  end

  def message
    UserMailer.deliver_message(current_user.email, @event, params[:message])
    flash[:notice] = 'Email delivered'
    redirect_to :action => 'show', :id => @event
  end

  def remove
    @event = Event.find(params[:id])
    @event.destroy
=begin
    api = DIA_API_Simple.new API_OPTS
    records = api.get 'supporter_event', 'where' => "supporter_KEY=#{current_user.key}"
    rec = records.detect {|r| r['event_KEY'] == @event.dia_event.key}
    api.deleteKey 'supporter_event', rec['key'] unless rec.nil? || rec.empty?
=end
    redirect_to :action => 'index'
  end

  def attendees
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Email", "First_Name", "Last_Name", "Phone"]
      (@event.attendees || @event.to_democracy_in_action_event.attendees.collect {|a| User.new :email => a.Email, :first_name => a.First_Name, :last_name => a.Last_Name, :phone => a.Phone}).each do |sup|
        csv << [sup.email, sup.first_name, sup.last_name, sup.phone]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "event_#{@event.id}_attendees.csv")
  end

  protected
  def authorized?
    return true if %w(index).include?(action_name)
    @event = Event.find(params[:id])
    return true if current_user.admin?
    if %w(remove).include?(action_name)
      return true if current_user.attending.include?(@event)
    end
    return true if current_user.events.include?(@event)
    false
  end
end
