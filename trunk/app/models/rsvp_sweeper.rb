class RsvpSweeper < ActionController::Caching::Sweeper
  observe Rsvp

  def after_create(record)
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'events','show',"#{record.event.id}.html")) rescue Errno::ENOENT    
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,'events','show',"#{record.event.id}.html")) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Expired caches for new rsvp")
  end

end
