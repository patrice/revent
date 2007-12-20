class Admin::TriggersController < AdminController 
  def index
  end

	active_scaffold :trigger do |config|
    config.label = "Email Response Triggers"
  	config.columns = [:type, :calendar, :site, :from_name, :from, :reply_to, :bcc, :subject, :email_text, :email_html]
  	config.columns[:type].form_ui = :select         # just want drop down on form (no crazy subforms)
  	config.columns[:calendar].form_ui = :select     # just want drop down on form (no crazy subforms)
  	config.columns[:calendar].clear_link            # don't want calendar link on list
  	config.columns[:calendar].description = "Calendar specific triggers over-ride 'All Calendars' triggers"
  	config.columns[:calendar].label = "Apply to Calendar"
  	config.columns[:type].label = "Email Trigger"
  	config.columns[:from].label = "From Email Address"
  	config.columns[:from_name].label = "From Name"
  	config.columns[:email_html].label = "Email HTML"
  	config.columns[:email_text].label = "Email Text"
  	config.list.columns = [:type, :calendar, :subject, :from_name, :from]
  	config.list.sorting = [{:calendar => :asc}, {:type => :asc}]
  end

  def before_create_save(trigger)
    trigger.site_id = Site.current.id
  end
end

