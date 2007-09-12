class InvitesController < ApplicationController  

  def index
  end

  def nearby
    districts = ZipCode.find_districts_near_postal_code(params[:postal_code]) 
    if districts.length > 5
      close_districts = ZipCode.find_districts_near_postal_code(params[:postal_code], 10, 20)
      districts = close_districts + ZipCode.find_districts_near_postal_code(params[:postal_code], 20, 60)
    end
    states = ZipCode.find_states_near_postal_code(params[:postal_code])
    @politicians = []
    @politicians << Politician.find_all_by_district(districts)
    @politicians << Politician.find_all_by_district(states.collect {|s| ["#{s}1","#{s}2"]}.flatten)
    @politicians.flatten!
    @event = Event.new :name => 'the events'
    render :action => 'all'
  end

  def all
    @event = @calendar.events.find(params[:id])
    @politicians = []
    # get representative for this event's district
    @politicians << Politician.find_by_district(@event.district)
    # get both senators for this event's state 
    @politicians << Politician.find_by_district(@event.state + "1")
    @politicians << Politician.find_by_district(@event.state + "2")
  end

  def list
    non_states = ["none", "ot", "GU", "PR", "VI", "NT", "AB", "BC", "MB", "NF", "NB", "NT", "NU", "ON", "PE", "QC", "SK", "YT", "AS"].freeze
    @states = DemocracyInAction::Helpers.state_options_for_select.collect {|s| s[1]} - non_states
    @display_state =  params[:state].nil? ? @states.first : params[:state]
    @politicians = Politician.find_all_by_state(@display_state, :include => :politician_invites, :order => 'district_type desc')
  end
  
  def search
    @politicians = Politican.find_by_state(params[:state])
  end

  def write
    @event = @calendar.events.find(params[:id])
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end
  
  def call
    @event = @calendar.events.find(params[:id])
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end

  def email
    @event = @calendar.events.find(params[:id])
    @politician = Politician.find(params[:politician_id])
    @user = current_user
  end

  def create
    @event = @calendar.events.find(params[:id])
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
    @event = @calendar.events.find(params[:id])
    @politician = Politician.find(params[:politician_id])
  end
  
  def flashmap_pois
    @level = params[:level]
    state = case @level
            when "2"
              params[:area][3..4].upcase
            when "3"
              params[:subarea][3..4].upcase
            else
              nil
            end
    if state
      @events = @calendar.events.find(:all, :conditions => ["latitude <> 0 AND longitude <> 0 AND state = ?", state])
    else
      @events = @calendar.events.find(:all, :conditions => "latitude <> 0 AND longitude <> 0")
    end
    render :layout => false
  end

  def flashmap_area_states
    @totals = Flashmaps::DISTRICTS.inject({}) {|counts, district| counts[district[0]].nil? ? counts[district[0]] = 1 : counts[district[0]] += 1; counts}
    @action_total = @calendar.events.count
    @states = Flashmaps::STATES
    render :layout => false
  end

  def flashmap_area_state
    @state = params[:state] || ""
    render :layout => false
  end
  
  def flashmap_area_districts
    @state = params[:state]
    @districts = Flashmaps::DISTRICTS.select {|d| d[0] == "us_#{@state.downcase}"}
    render :layout => false
  end
end
