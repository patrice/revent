class CalendarSweeper < ActionController::Caching::Sweeper
  observe Calendar

  def after_update(record)
    Cache.delete("site_for_host_#{record.site.host}") rescue NameError
  end
end
