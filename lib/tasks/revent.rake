namespace :revent do
  desc "Load sites table with local domains"
  task :setup_sites do
    load 'config/environment.rb'
    domain = "." + ( ENV['DOMAIN'] || "local_revent.org" )
    Site.find(:all).each do |s| 
      name = s.theme || s.host[/.+\.(.+)\.[^\.]+$/][1]
      s.update_attribute(:host, name + domain) 
    end
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
