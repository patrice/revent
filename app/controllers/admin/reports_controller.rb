class Admin::ReportsController < AdminController
  cache_sweeper :report_sweeper, :only => [:create, :update, :destroy]

  active_scaffold :reports do |config|
    config.columns = [:created_at, :event, :reporter_name, :attendees, :status, :featured, :attachments, :embeds]
    config.show.columns = [:created_at, :event, :reporter_email, :reporter_name, :text, :attendees, :status, :featured, :attachments, :embeds]
    config.update.columns = [:status, :featured, :text, :attendees]
    config.columns[:attendees].label = "Estimated attendance"
    config.columns[:attachments].label = "# of Attachments"
    config.columns[:embeds].label = "# of Embeds"

   	config.action_links.add 'edit', 
   	  {:label => 'Edit', :controller => 'account/reports', :action => 'show', :type => :record, :inline => false} 
    
    config.columns[:attachments].clear_link    
    config.columns[:embeds].clear_link    
  	columns[:featured].list_ui = :checkbox
  	columns[:featured].form_ui = :checkbox
  	config.list.sorting = [{:created_at => :desc}]
  	config.actions.exclude :create
  end

  def conditions_for_collection
    ["events.calendar_id IN (#{(@calendar.calendar_ids << @calendar.id).join(',')})"]
  end

  def index
  end
end
