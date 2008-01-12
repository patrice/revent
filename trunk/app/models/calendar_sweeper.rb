class CalendarSweeper < ActionController::Caching::Sweeper
  observe Calendar

  def after_update(calendar)
    Cache.delete("site_for_host_#{calendar.site.host}") rescue NameError
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,"index.html")) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,"index.html")) rescue Errno::ENOENT
  end
end
