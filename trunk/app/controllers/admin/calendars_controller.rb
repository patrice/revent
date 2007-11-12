class Admin::CalendarsController < AdminController 
	def index
	
	end

  active_scaffold :calendar do |config|
  	config.columns = [:name, :permalink, :short_description, :event_start, :event_end, :signup_redirect, :hostform, :rsvp_dia_group_key, :rsvp_dia_trigger_key, :rsvp_redirect,  :report_title_text, :report_intro_text, :report_dia_group_key, :report_dia_trigger_key, :report_redirect, :flickr_tag, :flickr_additional_tags, :flickr_photoset, :current, :theme, :letter_script, :call_script,  :site ]
  	#config.update.columns = [:name, :permalink, :short_description, 
    #                  :signup_redirect, :hostform, :current, :theme, :letter_script, :call_script ]
  	config.list.columns = [:current, :name, :events_count, :site]
  	config.list.sorting = [{ :name => :asc}]
  	columns[:current].list_ui = :checkbox
  	columns[:current].form_ui = :checkbox
  	columns[:hostform].form_ui = :select

  end

  def conditions_for_collection
    [ "site_id = ?", Site.current.id ]
    #{:conditians => [ "site_id = ?", Site.current.id ]}
    #{ :conditions => {:site => Site.current.id }}
    #"site_id=#{Site.current.id}"
  end
  
  
end
=begin 
class Admin::CalendarsController < AdminController
  skip_before_filter :set_calendar
  def index
    if Site.current.calendars.count > 1
      @calendars = Site.current.calendars
      @calendar = Site.current.calendars.current
    else
      redirect_to :controller => 'admin/events', :permalink => Site.current.calendars.current.permalink
    end
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ]

  # /admin/calendars/show?id=
  def show
    @calendar = Calendar.find(params[:id])
    @events = @calendar.events
    render :action => 'show'
  end

  # /admin/calendars/new
  def new
    @calendar = Calendar.new
  end

  # /admin/calendars/create
  def create
    @calendar = @site.calendars.build(params[:calendar])
    if @calendar.save
      flash[:notice] = 'Calendar was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  # /admin/calendars/edit?id=
  def edit
    @calendar = Calendar.find(params[:id])
  end

  # /admin/calendars/update?id=
  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update_attributes(params[:calendar])
      flash[:notice] = 'Calendar was successfully updated.'
      redirect_to calendars_url
    else
      render :action => 'edit'
    end
  end

  # /admin/calendars/destroy?id=
  def destroy
    Calendar.find(params[:id]).destroy
    flash[:notice] = 'Calendar was successfully destroyed.'    
    redirect_to :action => 'index'
  end

  # /admin/calendars/:id/events
  def events
    @calendar = Calendar.find(params[:id], :include => :events)
    @events = @calendar.events
  end

end
=end 
