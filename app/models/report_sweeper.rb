class ReportSweeper < ActionController::Caching::Sweeper
  observe Report

  def after_save(record)
    expire_page :controller => "/reports", :action => "show", :event_id => record.event
    expire_page :controller => "/events", :action => "show", :id => record.event
    expire_page :controller => "/reports", :action => "list"
    expire_page :controller => "/reports", :action => "search", :state => record.event.state if record.event && record.event.state
#    expire_page :controller => "/reports", :action => "flashmap", :format => 'xml'
    FileUtils.rm_rf(File.join(ActionController::Base.page_cache_directory,'reports','page')) rescue Errno::ENOENT

    expire_page :controller => "/reports", :action => "press" unless record.press_links.empty?
    expire_page :controller => "/reports", :action => "video" if not record.embeds.empty?
    record.attachments.each {|a| expire_page :controller => "/reports", :action => "lightbox", :id => a.id}
  end

  alias after_destroy after_save
end
