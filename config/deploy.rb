set :application, "revent"
set :user, "revent"
set :runner, "#{user}"

set :scm, :git
set :repository, "git://github.com/pfdemuizon/#{application}.git"

set :deploy_to, "/home/revent/revent"
set :deploy_via, :remote_cache

set :use_sudo, true
set :chmod755, %w(app config db lib public vendor script tmp public/dispatch.cgi public/dispatch.fcgi public/dispatch.rb)
set :keep_releases, 3
task :before_deploy do
  deploy:cleanup
end

role :web, "slicehost.radicaldesigns.org"
role :app, "slicehost.radicaldesigns.org"
role :db,  "slicehost.radicaldesigns.org"

desc <<DESC
An imaginary backup task. (Execute the 'show_tasks' task to display all
available tasks.)
DESC
task :backup, :roles => :db, :only => { :primary => true } do
  # the on_rollback handler is only executed if this task is executed within
  # a transaction (see below), AND it or a subsequent task fails.
  on_rollback { delete "/tmp/dump.sql" }

  run "mysqldump -u theuser -p thedatabase > /tmp/dump.sql" do |ch, stream, out|
    ch.send_data "thepassword\n" if out =~ /^Enter password:/
  end
end

desc "Demonstrates the various helper methods available to recipes."
task :helper_demo do
  setup

  buffer = render("maintenance.rhtml", :deadline => ENV['UNTIL'])
  put buffer, "#{shared_path}/system/maintenance.html", :mode => 0644
  sudo "killall -USR1 dispatch.fcgi"
  run "#{release_path}/script/spin"
  delete "#{shared_path}/system/maintenance.html"
end

desc "A task demonstrating the use of transactions."
task :long_deploy do
  transaction do
    update_code
    disable_web
    symlink
    migrate
  end

  restart
  enable_web
end

desc <<-DESC
Spinner is run by the default cold_deploy task. Instead of using script/spinner, we're just gonna rely on Mongrel to keep itself up.
DESC
task :spinner, :roles => :app do
  run "mongrel_rails cluster::start"
#  run "killall dispatch.fcgi"
end

desc "Restart the web server"
task :restart, :roles => :app do
  begin
    run "cd #{current_path} && mongrel_rails cluster::restart"
#    run "cd #{current_path} && killall dispatch.fcgi"
  rescue RuntimeError => e
    puts e
    puts "Probably not a big deal, so I'll just keep trucking..."
  end
end

task :after_update_code, :roles => :app, :except => {:no_symlink => true} do
  run <<-CMD
    cd #{release_path} &&
    ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml &&
    ln -nfs #{shared_path}/config/mongrel_cluster.yml #{release_path}/config/mongrel_cluster.yml &&
    ln -nfs #{shared_path}/config/cartographer-config.yml #{release_path}/config/cartographer-config.yml &&
    ln -nfs #{shared_path}/config/democracyinaction-config.yml #{release_path}/config/democracyinaction-config.yml &&
    ln -nfs #{shared_path}/config/flickr #{release_path}/config/flickr &&
    ln -nfs #{shared_path}/config/amazon_s3.yml #{release_path}/config/amazon_s3.yml &&
    ln -nfs #{shared_path}/vendor/aws-s3-0.3.0 #{release_path}/vendor/aws-s3-0.3.0 &&
    ln -nfs #{shared_path}/vendor/mime-types-1.15 #{release_path}/vendor/mime-types-1.15 &&
    ln -nfs #{shared_path}/vendor/rflickr-2006.02.01 #{release_path}/vendor/rflickr-2006.02.01 &&
    ln -nfs #{shared_path}/sites #{release_path}/sites
  CMD
end

task :after_symlink, :roles => :app , :except => {:no_symlink => true} do
  run <<-CMD
    cd #{release_path} &&
    ln -nfs #{shared_path}/public/attachments #{release_path}/public/attachments &&
    rake theme_update_cache --trace
  CMD
end 

desc "Set the proper permissions for directories and files on HostingRails accounts"
task :after_deploy do
  run(chmod755.collect do |item|
    "chmod 755 #{current_path}/#{item}"
  end.join(" && "))
end

desc 'Dumps the production database to db/production_data.sql on the remote server'
task :remote_db_dump, :roles => :db, :only => { :primary => true } do
  run "cd #{deploy_to}/#{current_dir} && " +
    "#{rake} RAILS_ENV=#{rails_env} db:database_dump --trace" 
end

desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
task :remote_db_download, :roles => :db, :only => { :primary => true } do  
  execute_on_servers(options) do |servers|
    self.sessions[servers.first].sftp.connect do |tsftp|
      tsftp.get_file "#{deploy_to}/#{current_dir}/db/production_data.sql", "db/production_data.sql" 
    end
  end
end

desc 'Cleans up data dump file'
task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do  
  delete "#{deploy_to}/#{current_dir}/db/production_data.sql" 
end 

desc 'Dumps, downloads and then cleans up the production data dump'
task :remote_db_runner do
  remote_db_dump
  remote_db_download
  remote_db_cleanup
end
