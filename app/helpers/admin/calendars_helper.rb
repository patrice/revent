module Admin::CalendarsHelper
  def permalink_column (calendar)
    link_to 'Preview', :controller => '/events', :permalink => calendar.permalink 
  end
  def name_column (calendar)
    link_to calendar.name, :controller => '/admin/calendars', :action => :edit, :id => calendar.id
  end
  def events_count_column(calendar)
    "#{calendar.events.count} events"
  end
  def letter_script_form_column(record, input_name)
    text_area :record, :letter_script, 'rows' => 20, :cols => 65, :name => input_name
  end
  
  def call_script_form_column(record, input_name)
    text_area :record, :call_script, 'rows' => 20, :cols => 65, :name => input_name
  end

  def permalink_form_column(record, input_name)
    if record.permalink
      record.permalink
    else
      text_field(:record, :permalink)
    end
  end
  
  def theme_form_column(record, input_name)
    if record.theme
      record.theme
    else
      text_field(:record, :theme )
    end
  end

  def site_id_form_column(record, input_name)
    return Site.find(record.site_id).host if record.site_id
    record.site_id = Site.current.id
    text_field(:record, :site_id)
  end

  def signup_redirect_form_column(record, input_name)
    input :record, :signup_redirect, :size => 50, :class => 'text-input'
  end
  
end
