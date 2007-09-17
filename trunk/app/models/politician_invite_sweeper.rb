class PoliticianInviteSweeper < ActionController::Caching::Sweeper
  observe PoliticianInvite

  def after_save(record)
    expire_page(:controller => 'invite', :action => 'totals')
    RAILS_DEFAULT_LOGGER.info("Expired caches for new politician invites")
  end
end
