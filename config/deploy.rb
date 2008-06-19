set :application, "revent"
set :repository, "git@github.com:pfdemuizon/#{application}.git"

set :user, "#{application}"
set :group, "#{user}"
#set :runner, "#{user}"

set :deploy_to, "/home/#{user}/#{application}"
set :scm, :git

role :web, "slicehost.radicaldesigns.org"
role :app, "slicehost.radicaldesigns.org"
role :db,  "slicehost.radicaldesigns.org", :primary => true

#set :deploy_via, :remote_cache
set :git_enable_submodules, 1

set :use_sudo, true 

after "deploy:update_code", "deploy:symlink_shared"
after "deploy:symlink_shared", "deploy:after_symlink"

namespace :deploy do
  desc "Start the server"
  task :start, :roles => :app do
    invoke_command "monit -g #{group} start all", :via => run_method
  end

  desc "Stop the server"
  task :stop, :roles => :app do
    invoke_command "monit -g #{group} stop all", :via => run_method
  end

  desc "Restart the server"
  task :restart, :roles => :app do
    invoke_command "monit -g #{group} restart all", :via => run_method
  end

  task :symlink_shared, :roles => :app, :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    invoke_command "ln -nfs #{shared_path}/config/mongrel_cluster.yml #{release_path}/config/mongrel_cluster.yml"
    invoke_command "ln -nfs #{shared_path}/config/cartographer-config.yml #{release_path}/config/cartographer-config.yml"
    invoke_command "ln -nfs #{shared_path}/config/democracyinaction-config.yml #{release_path}/config/democracyinaction-config.yml"
    invoke_command "ln -nfs #{shared_path}/config/flickr #{release_path}/config/flickr"
    invoke_command "ln -nfs #{shared_path}/config/amazon_s3.yml #{release_path}/config/amazon_s3.yml"
    invoke_command "ln -nfs #{shared_path}/vendor/aws-s3-0.3.0 #{release_path}/vendor/aws-s3-0.3.0"
    invoke_command "ln -nfs #{shared_path}/vendor/mime-types-1.15 #{release_path}/vendor/mime-types-1.15"
    invoke_command "ln -nfs #{shared_path}/vendor/rflickr-2006.02.01 #{release_path}/vendor/rflickr-2006.02.01"
    invoke_command "ln -nfs #{shared_path}/sites #{release_path}/sites"
  end

  task :after_symlink, :roles => :app , :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/public/attachments #{release_path}/public/attachments"
    invoke_command "cd #{release_path} && rake theme_update_cache"
  end 
end

set :rails_env, "production"
set :rake, "rake"

namespace :db do
  desc 'Dumps the production database to db/production_data.sql on the remote server'
  task :remote_dump, :roles => :db, :only => { :primary => true } do
    invoke_command "cd #{release_path}"
    invoke_command "#{rake} RAILS_ENV=#{rails_env} db:database_dump --trace" 
  end

  desc 'Compress the production database dump to zip file'
  task :remote_compress, :roles => :db, :only => { :primary => true } do
    invoke_command "zip db/#{RAILS_ENV}_data.zip db/#{RAILS_ENV}_data.sql"
  end

  desc 'Downloads db/production_data.zip from the remote production environment to your local machine'
  task :remote_download, :roles => :db, :only => { :primary => true } do  
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.get_file "#{release_path}/db/production_data.zip", "db/production_data.zip" 
      end
    end
  end

  desc 'Uncompress the production database zip file'
  task :remote_compress, :roles => :db, :only => { :primary => true } do
    invoke_command "unzip db/#{RAILS_ENV}_data.zip"
  end

  desc 'Cleans up data dump file and zip file'
  task :remote_cleanup, :roles => :db, :only => { :primary => true } do  
    delete "#{release_path}/db/production_data.sql" 
    delete "#{release_path}/db/production_data.zip" 
  end 

  desc 'Dumps, compress, downloads and then cleans up the production data dump'
  task :remote_runner do
    remote_dump
    remote_compress
    remote_download
    remote_uncompress
    remote_cleanup
  end
end
