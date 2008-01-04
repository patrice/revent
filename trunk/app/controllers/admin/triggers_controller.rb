class Admin::TriggersController < AdminController 
  def index
  end

	active_scaffold :trigger do |config|
    config.label = "Email Response Triggers"
  	config.columns = [:name, :calendar, :site, :from_name, :from, :reply_to, :bcc, :subject, :email_text, :email_html]
  	config.columns[:calendar].form_ui = :select     # just want drop down on form (no crazy subforms) 	
  	config.columns[:calendar].clear_link            # just want calendar name on list (no links)
#  	config.columns[:calendar].description = "Calendar triggers over-ride 'All Calendars' triggers"
  	config.columns[:calendar].label = "Apply to calendar"
  	config.columns[:name].label = "Email trigger"
  	config.columns[:from].label = "From email address"
  	config.list.columns = [:name, :calendar, :subject, :from_name, :from]
  	config.list.sorting = [{:calendar => :asc}, {:name => :asc}]
  end

  def before_create_save(trigger)
    trigger.site_id = Site.current.id
  end
end

