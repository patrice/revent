class Admin::Calendars2Controller < AdminController 
	def index
	
	end

  active_scaffold :calendar do |config|
  	config.columns = [:name, :permalink, :short_description, :event_start, :event_end, :signup_redirect, :hostform, :rsvp_dia_group_key, :rsvp_dia_trigger_key, :rsvp_redirect,  :report_title_text, :report_intro_text, :report_dia_group_key, :report_dia_trigger_key, :report_redirect, :flickr_tag, :flickr_additional_tags, :flickr_photoset, :current, :theme, :letter_script, :call_script,  :site ]
  	config.list.columns = [:name, :permalink, :site]
  	config.list.sorting = [{ :name => :asc}]
  	columns[:site].ui_type = :select
  	columns[:hostform].ui_type = :select

  end
  
  
end
