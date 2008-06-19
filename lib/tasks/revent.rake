namespace :revent do
  desc "Load sites table with local domains"
  task :set_local_sites do
    load 'config/environment.rb'
    domain = ".local_daysofaction.org"
    Site.find(:all).each {|s| s.update_attribute(:host, s.host[/.+\.(.+)\..+/, 1] + domain)}
  end
end
