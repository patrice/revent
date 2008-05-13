module CalendarsHelper
  def calendar_select
    Site.current.sorted_calendars.collect{|c| [c.name, c.permalink]}
  end
end
