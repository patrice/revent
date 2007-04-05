class EventSweeper < ActionController::Caching::Sweeper
  observe Event

  def after_create(record)
    expire_event_list_pages(record)
    RAILS_DEFAULT_LOGGER.info("Expired caches for new event")
  end

  def after_update(record)
    expire_event_pages_and_fragments(record)
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'events','search','state',"#{record.state}.html")) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Expired caches for updated event #{record.id}")
  end

  def after_destroy(record)
    expire_event_pages_and_fragments(record)
    expire_event_list_pages(record)
    RAILS_DEFAULT_LOGGER.info("Expired caches for deleted event #{record.id}")
  end

  protected
  def expire_event_list_pages(record)
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'events','search','state',"#{record.state}.html")) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'events','flashmap.xml')) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'events','total.html')) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,'index.html')) rescue Errno::ENOENT
  end

  def expire_event_pages_and_fragments(record)
    FileUtils.rm(File.join(ActionController::Base.page_cache_directory,"events/show/#{record.id}.html")) rescue Errno::ENOENT
    FileUtils.rm(File.join(ActionController::Base.fragment_cache_store.cache_path, "events/_report/event_#{record.id}_list_item.cache")) rescue Errno::ENOENT
  end
end
