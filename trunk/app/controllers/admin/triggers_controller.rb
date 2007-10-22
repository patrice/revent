class Admin::TriggersController < AdminController 

  def index
    
  end

	active_scaffold :trigger do |config|
    config.label = "Email Response Triggers"
  	config.list.columns = [:name, :subject, :calendar, :site]
  	config.list.sorting = [{ :calendar => :asc}, {:name => :asc}]
  	config.columns = [:name, :calendar, :subject, :from_name, :from, :reply_to, :bcc, :email_html, :email_text, :site ]
  	columns[:calendar].ui_type = :select
	columns[:site].ui_type = :select
  end
end
