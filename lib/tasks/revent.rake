namespace :revent do
  desc "Load sites table with local domains"
  task :setup_sites do
    load 'config/environment.rb'
    domain = ".local_daysofaction.org"
    Site.find(:all).each {|s| s.update_attribute(:host, s.host[/.+\.(.+)\..+/, 1] + domain)}
  end
end
=begin
namespace :db do
  desc "Seed the database with necessary data"
  task :seed do
    load 'config/environment.rb'
  end
end
=end
