class Admin::HostformsController < AdminController 

  def index
    
  end

	active_scaffold :hostforms do |config|
    config.label = "Event Host Sign Up Forms"
  	config.columns = [:title, :intro_text, :event_info_text,  :pre_submit_text, :thank_you_text,  :dia_trigger_key, :dia_group_key, :dia_user_tracking_code, :dia_event_tracking_code, :tag, :redirect, :calendar, :site]
  	
  	config.list.columns = [:title, :calendar, :site ]
  	config.list.sorting = [{ :calendar => :asc}, {:title => :asc}]
  	columns[:calendar].ui_type = :select
	columns[:site].ui_type = :select
  end
end

