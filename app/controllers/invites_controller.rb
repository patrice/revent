#require 'ruby-debug'

class InvitesController < ApplicationController  
  before_filter :disable_invites_when_event_past, :only => [:events, :list, :search, :state, :write, :call, :email, :thank_you, :create, :congress_invited, :congress_attending, :candidates_invited, :candidates_attending]
  before_filter :find_or_initialize_event, :only => [:write, :call, :email]
  session :off
  layout 'invites'
  
  after_filter(:only => [:totals, :widget, :index, :map, :flashmap_area_states, :flashmap_area_districts, :flashmap_area_state]) do |c| 
    c.cache_page(nil, :permalink => c.params[:permalink])
  end

  caches_action :flashmap_pois
  # using the action_cache plugin http://www.agilewebdevelopment.com/plugins/action_cache
  def action_fragment_key(options)
    (url_for(options). + '?' + params.sort.collect {|k,v| "#{k}=#{v}"}.join('&') + "&version=#{flashmap_cache_version}").gsub(/\s+/,'')
  end

  def flashmap_cache_version
    Cache.get("site_#{Site.current.id}_flashmap_version") { rand(10000) }
  end

  def disable_invites_when_event_past
    redirect_to home_url if @calendar.past?
  end

  def widget
    count
    respond_to do |format|
      format.html { render(:layout => false) }
      format.js { 
        @content = render_to_string(:layout => false)
        extend ActionView::Helpers::JavaScriptHelper
        render :update do |page|
          page << "document.write('#{escape_javascript(@content)}');"
        end
      }
    end
  end

  def count
    @total_user_invites = PoliticianInvite.count
    @congress_invites = Politician.count :include => :politician_invites, :conditions => "(district_type = 'FS' OR district_type = 'FH') AND politician_invites.id"
    @candidate_invites = Candidate.count :include => :politician_invites, :conditions => "politician_invites.id"

    @congress_rsvps = Politician.count :include => :rsvps, :conditions => "(district_type = 'FS' OR district_type = 'FH') AND rsvps.id"
    @candidate_rsvps = Candidate.count :include => :rsvps, :conditions => "rsvps.id and office = 'president'"
  end

  def totals
    count
    respond_to do |format|
      format.html { render(:layout => false) }
      format.js { 
        @content = render_to_string(:layout => false)
        extend ActionView::Helpers::JavaScriptHelper
        render :update do |page|
          page << "document.write('#{escape_javascript(@content)}');"
        end
      }
    end
  end

  # find events near politician (params[:politician_id]) to invite them to
  def events
    @politician = Politician.find_by_district(params[:politician_id]) if params[:politician_id] =~ /[A-Z]{2}\d+/
    @politician ||= Politician.find(params[:politician_id])
    if @politician.is_a?(Candidate)
      @events = @calendar.events.sort {|a,b| state = a.state <=> b.state; state == 0 ? a.city.downcase <=> b.city.downcase : state}
    else # congress-person
      @events = @calendar.events.find(:all, :conditions => ["state = ?", @politician.state])
    end
    @events.reject!{|e| e.past?}
    @events_select = []
    @events_select << ['--- SELECT AN ACTION ---', 'none']
    @events.each {|e| @events_select << ["#{[e.city, e.state].join(', ')} - #{e.name}", e.id]}
  end

  def index
    map
    render :action => 'map'
  end

  def map
  end

  def find_nearby
    districts = ZipCode.find_districts_near_postal_code(params[:postal_code]) 
    if districts.length > 5
      close_districts = ZipCode.find_districts_near_postal_code(params[:postal_code], 10, 20)
      districts = close_districts + ZipCode.find_districts_near_postal_code(params[:postal_code], 20, 60)
    end
    searched_states = ZipCode.find_states_near_postal_code(params[:postal_code])
    @display_state = searched_states.first
    @politicians = []
    @politicians << Politician.find_all_by_district(districts)
    @politicians << Politician.find_all_by_district(searched_states.collect {|s| ["#{s}1","#{s}2"]}.flatten)
    @politicians.flatten!
  end

  def all
    @event = @calendar.events.find(params[:id])
    @politicians = []
    # get both senators for this event's state 
    @politicians << Politician.find_all_by_state(@event.state, :conditions => "district_type = 'FS'")
    # get representative for this event's district
    @politicians << Politician.find_all_by_district(@event.district)
    @politicians.flatten!
  end
  
  def state
    @event = @calendar.events.find(params[:id])
    # get representative for this event's state
    @politicians = Politician.find_all_by_state(@event.state)
    render :action => 'all'
  end

  after_filter(:only => :list) {|c| c.cache_page(nil, :permalink => c.params[:permalink]) }
  def list
    @states = valid_states
    respond_to do |format|
      format.html { @politicians = params[:state] ? 
        Politician.find_all_by_state(params[:state], :include => [:rsvps, :politician_invites], :order => 'district_type DESC, district ASC') :
        Candidate.find(:all, :include => [:rsvps, :politician_invites], :conditions => "office = 'president'")
      }
      format.js { 
        @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites])
        @list = render_to_string(:action => 'list', :layout => false)
        render :layout => false
      }
      format.xml { 
        @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites])
        invites = politician_list_to_hash(@politicians)
#          :disclaimer => 'disclaimer' }
        render :xml => {:politicians => invites}.to_xml 
      }
      format.json {
        @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites])
        invites = politician_list_to_hash(@politicians)
        render :json => {:politicians => invites}.to_json 
      }
    end
  end
  
  def politician_list_to_hash(list)
    list.collect do |p|
      {
        :district => p.district, :display_name => p.display_name,
        :invited => p.invited?, :attending => p.attending?,
        :image_url => p.image_url,
        :invite_url => url_for(:controller => :invites, :action => :events, :id => p.id)
      }
    end 
  end

  def valid_states
    non_states = ["none", "ot", "GU", "PR", "VI", "NT", "AB", "BC", "MB", "NF", "NB", "NT", "NU", "ON", "PE", "QC", "SK", "YT", "AS"].freeze
    DemocracyInAction::Helpers.state_options_for_select.collect {|s| s[1]} - non_states
  end

  def search
    find_nearby
    @states = valid_states
    invites = politician_list_to_hash(@politicians)
    respond_to do |format|
      format.html { render :action => 'list' }
      format.json { render :json => {:politicians => invites}.to_json }
      format.xml { render :xml => {:politicians => invites}.to_xml}
      format.js { 
        @list = render_to_string(:action => :list, :layout => false)
        render :layout => false 
      }
    end
    cache_page nil, :permalink => @calendar.permalink, :postal_code => params[:postal_code]
  end

  def senators
    @politicians = Politician.find_all_by_district_type('FS', :include => [:rsvps, :politician_invites], :order => 'district')
    subset
  end

  def representatives
    @politicians = Politician.find_all_by_district_type('FH', :include => [:rsvps, :politician_invites], :order => 'district')
    subset
  end

  def candidates
    if params[:office] == 'congress'
      @politicians = Candidate.find(:all, :conditions => "office = 'senator' or office = 'representative'", :include => [:rsvps, :politician_invites], :order => "last_name")
    else
      @politicians = Candidate.find_all_by_office(params[:office], :include => [:rsvps, :politician_invites], :order => "last_name")
    end
    subset
  end

  def subset
    @states = valid_states
    @display_state = @states.first
    invites = politician_list_to_hash(@politicians)
    respond_to do |format|
      format.html { render :action => 'list' }
      format.json { render :json => {:politicians => invites}.to_json }
      format.xml { render :xml => {:politicians => invites}.to_xml}
      format.js { 
        @list = render_to_string(:action => :list, :layout => false)
        render :action => :search, :layout => false 
      }
    end
  end

  def write
    @politician = Politician.find(params[:politician_id])
    @user = current_user
    @event.letter_script ||= @calendar.letter_script.gsub('CITY_STATE', [@event.city, @event.state].join(', ')) if @calendar.letter_script
    @letter_script = RedCloth.new @event.letter_script
  end
  
  def call
    @politician = Politician.find(params[:politician_id])
    @user = current_user
    @event.call_script ||= @calendar.call_script.gsub('CITY_STATE', [@event.city, @event.state].join(', ')) if @calendar.call_script
    @event.call_script.gsub!('POLITICIAN_NAME', @politician.display_name)
    @call_script = RedCloth.new @event.call_script
  end

  def email
    @politician = Politician.find(params[:politician_id])
    @user = current_user
    @recipient = @politician.democracy_in_action_object
    if @recipient && @recipient.local && !@recipient.local['email'] && @recipient.local['web_form_url']
      @event.letter_script ||= @calendar.letter_script.gsub('CITY_STATE', [@event.city, @event.state].join(', ')) if @calendar.letter_script
      @letter_script = RedCloth.new @event.letter_script
      return
    end
    unless campaign = @event.campaign_for_politician(@politician)
      campaign = create_new_campaign(@event, @politician)
    end
    raise 'no campaign' unless campaign
    redirect_to_campaign(campaign)
  end

  def create_new_campaign(event, politician)
    extend ActionView::Helpers::TextHelper
    campaign = DemocracyInActionCampaign.new(
      'Reference_Name' => 'Invite ' + politician.display_name + ' to event ' + event.id.to_s,
      'Campaign_Title' => 'Invite ' + politician.display_name + ' to this action',
      'person_legislator_IDS' => politician.person_legislator_id,
      'recipient_KEYS' => politician.democracy_in_action_recipient_key,
#      'recipient_KEYS' => 121449, #jwarnow@gmail.com 
      'Suggested_Subject' => 'StepItUp',
#      'Letter_Salutation' => politician.title + politician.first_name + politician.last_name,
      'Suggested_Content' => event.letter_script || @calendar.letter_script.gsub('CITY_STATE', [@event.city, @event.state].join(', ')),
      'Max_Number_Of_Faxes' => 100, #100?
      'Hide_Message_Type_Options' => 1,
      'Hide_Keep_Me_Informed' => 1,
      'Default_Tracking_Code' => "distributed_event_KEY#{@calendar.democracy_in_action_key}",
      'redirect_path' => invite_url(:permalink => @calendar.permalink, :controller => 'invites', :action => 'thank_you', :id => @event, :politician_id => politician.id)
    )
    key = campaign.save
    event.democracy_in_action_campaigns.create :table => 'campaign', :key => key, :local => campaign
    campaign
  end

  def redirect_to_campaign(campaign)
    config = DemocracyInAction::Config.new(File.join(Site.current_config_path, 'democracyinaction-config.yml'))
    redirect_to "http://www.democracyinaction.org/dia/organizations/" + config['short_name'] + "/campaign.jsp?campaign_KEY="+campaign.key
  end

  def create
    @event = @calendar.events.find(params[:id])
    @user = User.find_or_initialize_by_email(params[:user][:email]) # or current_user
    @user.attributes = params[:user]
#    unless @user.crypted_password || (@user.password && @user.password_confirmation)
#      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
#      @user.password = @user.password_confirmation = password
#    end
    @user.save
    invite = {}
    invite[:user_id] = @user.id
    invite[:politician_id] = params[:politician_id]
    invite[:event_id] = @event.id
    invite[:invite_type] = params[:invite_type]    
    @invite = PoliticianInvite.create(invite)
    thank_you and render :action => 'thank_you'
  end
    
  def thank_you
    @event = @calendar.events.find(params[:id])
    @politician = Politician.find(params[:politician_id])
  end
  
  #js
  def flashmaps
    @senators = Politician.find(:all, :conditions => "district_type = 'FS' and (type IS NULL OR type != 'Candidate')")
#    @representatives = Politician.find(:all, :conditions => "district_type = 'FH'")
    render :layout => false
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
      @events = @calendar.events.searchable.find(:all, :conditions => ["(latitude <> 0 AND longitude <> 0) AND events.state = ?", state], :include => :rsvpd_politicians)
    else
      @events = @calendar.events.searchable.find(:all, :conditions => "(latitude <> 0 AND longitude <> 0)", :include => :rsvpd_politicians)
    end
    @events = @events.sort_by {|e| e.rsvpd_politicians.length }
    render :layout => false
  end

  def flashmap_area_states
    @totals = Flashmaps::DISTRICTS.inject({}) {|counts, district| counts[district[0]].nil? ? counts[district[0]] = 1 : counts[district[0]] += 1; counts}
    @states = Flashmaps::STATES
    @politicians = Politician.find(:all, :conditions => "type IS NULL OR type != 'Candidate'", :include => [:rsvps, :politician_invites])
    render :layout => false
  end

  def flashmap_area_state
    @state = params[:state] || ""
    render :layout => false
  end
  
  def flashmap_area_districts
    @state = params[:state]
    @districts = Flashmaps::DISTRICTS.select {|d| d[0] == "us_#{@state.downcase}"}
    @politicians = Politician.find(:all, :conditions => ["state = ? and (type IS NULL OR type != 'Candidate')", @state], :include => [:rsvps, :politician_invites])
    render :layout => false
  end

  def flashmap_buttons
    area = params[:id]
    render "buttons"
  end

  def congress_invited
    @politicians = Politician.find :all, :include => :politician_invites, :conditions => "(district_type = 'FS' OR district_type = 'FH') AND politician_invites.id"
    render :action => 'list'
  end
  
  def congress_attending
    @politicians = Politician.find :all, :include => :rsvps, :conditions => "(district_type = 'FS' OR district_type = 'FH') AND rsvps.id"
    render :action => 'list'
  end
  
  def candidates_invited
    @politicians = Candidate.find :all, :include => :politician_invites, :conditions => "politician_invites.id and office = 'president'"
    render :action => 'list'
  end
  
  def candidates_attending
    @politicians = Candidate.find :all, :include => :rsvps, :conditions => "rsvps.id and office = 'president'"
    render :action => 'list'
  end

=begin
  # This method was used once to update DIA Campaigns to carry updated
  # suggested content for email invitations; should have done this from
  # console but hit snags trying to run render_to_string on console
  def update_dia
    extend ActionView::Helpers::TextHelper
    #debugger if ENV['RAILS_ENV'] == 'development';
    @user = nil
    objects = DemocracyInActionObject.find(:all).select{|o| o.table == 'campaign'}
    objects.each do |o|
      campaign = DemocracyInActionCampaign.find(o.key)
      @event = o.associated
      next unless @event
      campaign.Suggested_Content = strip_tags(render_to_string(:partial => 'letter_content'))
      campaign.save
    end
  end
=end

  protected
  def find_or_initialize_event
    if params[:id] == 'all'
      @event = @calendar.events.build :name => 'an event'
    else
      @event = Event.find params[:id]
    end
  end

end
