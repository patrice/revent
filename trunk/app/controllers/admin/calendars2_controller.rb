class Admin::Calendars2Controller < AdminController 
	def index
	
	end

  active_scaffold :calendar do |config|
  	config.columns = [:name, :permalink, :short_description, :event_start, :event_end, :signup_redirect, :hostform, :current, :theme, :letter_script, :call_script, :site ]
  	config.list.columns = [:name, :permalink, :site]
  	config.list.sorting = [{ :name => :asc}]
  	columns[:site].ui_type = :select
  	columns[:hostform].ui_type = :select

  end
  
  
end