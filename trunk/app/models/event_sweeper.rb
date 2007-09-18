class EventSweeper < ActionController::Caching::Sweeper
  observe Event

  def after_create(record)
    expire_event_list_pages(record)
    RAILS_DEFAULT_LOGGER.info("Expired caches for new event")
  end

  def after_update(record)
    expire_event_pages_and_fragments(record)
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,'events','search','state',"#{record.state}.html")) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Expired caches for updated event #{record.id}")
  end

  def after_destroy(record)
    expire_event_pages_and_fragments(record)
    expire_event_list_pages(record)
    RAILS_DEFAULT_LOGGER.info("Expired caches for deleted event #{record.id}")
  end

  protected
  def expire_event_list_pages(record)
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,'events','search','state',"#{record.state}.html")) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,'events','flashmap.xml')) rescue Errno::ENOENT
#    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'events','total.html')) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'index.html')) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,'index.html')) rescue Errno::ENOENT
  end

  def expire_event_pages_and_fragments(record)
    expire_page :controller => '/events', :action => 'show', :id => record.id, :permalink => record.calendar.permalink
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,record.calendar.permalink,'events','show',"#{record.id}.html")) rescue Errno::ENOENT
    expire_fragment "events/_report/event_#{record.id}_list_item"
    Cache.delete "event_#{record.id}_marker" rescue NameError
  end
end
