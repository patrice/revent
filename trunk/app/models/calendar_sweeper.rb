class CalendarSweeper < ActionController::Caching::Sweeper
  observe Calendar

  def after_update(calendar)
    Cache.delete("site_for_host_#{calendar.site.host}") rescue NameError
  end
end
