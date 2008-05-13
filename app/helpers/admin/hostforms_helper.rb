module Admin::HostformsHelper
  def calendar_form_column(hostform, input_name)
    select_tag(input_name, options_for_select(Site.current.sorted_calendars.map{|c| [c.name, c.id]}, hostform.calendar.id))
  end
end
