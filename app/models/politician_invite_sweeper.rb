class PoliticianInviteSweeper < ActionController::Caching::Sweeper
  observe PoliticianInvite, Rsvp

  def after_save(record)
    case record
    when Rsvp
      @rsvp = record
      @politician = @rsvp.attending if @rsvp.attending.is_a?(Politician)
    when PoliticianInvite
      @politician = record.politician
    end
    #this must be something else
    return unless @politician

    #this politician has been invited / rsvpd before
    return unless @politician.politician_invites.length == 1 || @politician.rsvps.length == 1

    # expire event show page since it displays attending politicians
    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','events','show',@rsvp.event.id.to_s + '.*' ))) if @rsvp

    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','totals.*'))) rescue Errno::ENOENT
    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','list.*'))) rescue Errno::ENOENT

    state = @politician.state
    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','list','state',"#{state}.*"))) rescue Errno::ENOENT
    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','list','zip','*.*'))) rescue Errno::ENOENT

    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','flashmap','areas','states.*'))) rescue Errno::ENOENT
    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','flashmap','areas','state','#{state}.*'))) rescue Errno::ENOENT
    FileUtils.rm(Dir.glob(File.join(ActionController::Base.page_cache_directory,'*','invites','flashmap','areas','districts','#{state}.*'))) rescue Errno::ENOENT
    
#    CACHE.incr "site_#{Site.current.id}_flashmap_version"

    RAILS_DEFAULT_LOGGER.info("Expired caches for invites")
  end
end
