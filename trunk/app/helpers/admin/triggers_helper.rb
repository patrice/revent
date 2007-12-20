module Admin::TriggersHelper
  def calendar_form_column(record, input_name)
    calendars = Site.current.calendars.map{|c| [c.name, c.id]}
    calendars.insert(0, ["All Calendars", nil])
    select_tag input_name, options_for_select(calendars, (record.calendar ? record.calendar.id : "All Calendars"))
  end
  def calendar_column(record)
    h(record.calendar ? record.calendar.name : "All Calendars")
  end
end