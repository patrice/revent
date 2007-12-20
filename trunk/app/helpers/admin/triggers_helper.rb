module Admin::TriggersHelper
  def calendar_form_column(record, input_name)
    calendar_select = Site.current.calendars.map{|c| [c.name, c.id]}
    calendar_select.insert(0, ["All Calendars", nil])
    select_tag input_name, options_for_select(calendar_select, :select => record.type.name)
  end
  def calendar_column(record)
    h(record.calendar ? record.calendar.name : "All Calendars")
  end
end