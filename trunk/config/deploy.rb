

# =============================================================================
# ENGINE YARD REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :keep_releases, 3 
set :application,  'radical_designs'
set :repository,   'https://svn.radicaldesigns.org/daysofaction/trunk/'
#set :svn_username, ''
#set :svn_password, 'xew3fesl6'
set :user,         'radical_designs'
set :deploy_to,    "/data/#{application}"
set :checkout,     "export"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true. 

task :production do
   
  role :web, '65.74.169.199:8233'
  role :app, '65.74.169.199:8233'
  role :db, '65.74.169.199:8233', :primary => true
   
   
  role :app, '65.74.169.199:8234', :no_release => true, :no_symlink => true 
    
end

task :staging do
    
end

# =============================================================================
# TASKS

desc "Long deploy will throw up the maintenance.html page and run migrations 
      then it restarts and enables the site again."
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

task :after_update_code, :roles => :app, :except => {:no_symlink => true} do
  run <<-CMD
    cd #{release_path} &&
    ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml &&
    ln -nfs #{shared_path}/config/mongrel_cluster.yml #{release_path}/config/mongrel_cluster.yml &&
    ln -nfs #{shared_path}/config/cartographer-config.yml #{release_path}/config/cartographer-config.yml &&
    ln -nfs #{shared_path}/config/democracyinaction-config.yml #{release_path}/config/democracyinaction-config.yml &&
    ln -nfs #{shared_path}/config/flickr #{release_path}/config/flickr
  CMD
end

task :after_symlink, :roles => :app , :except => {:no_symlink => true} do
  run <<-CMD
    cd #{release_path} &&
    ln -nfs #{shared_path}/public/attachments #{release_path}/public/attachments
  CMD
end


# custome Engine Yard tasks. Don't change unless you know
# what you are doing!
task :after_deploy do
  cleanup
end  

task :after_deploy_with_migrations do
  cleanup
end

task :revision, :roles => :app do
  run %(tail -1 #{deploy_to}/revisions.log)
end

desc <<-DESC
Restart the Mongrel processes on the app server by calling restart_mongrel_cluster.
DESC
task :restart, :roles => :app do
  restart_mongrel_cluster
end

desc <<-DESC
Start the Mongrel processes on the app server by calling start_mongrel_cluster.
DESC
task :spinner, :roles => :app do
  start_mongrel_cluster
end
desc <<-DESC
Start Mongrel processes on the app server.  This uses the :use_sudo variable to determine whether to use sudo or not. By default, :use_sudo is
set to true.
DESC
task :start_mongrel_cluster , :roles => :app do
  sudo "/usr/bin/monit start all -g mongrel"
end

desc <<-DESC
Restart the Mongrel processes on the app server by starting and stopping the cluster. This uses the :use_sudo
variable to determine whether to use sudo or not. By default, :use_sudo is set to true.
DESC
task :restart_mongrel_cluster , :roles => :app do
  sudo "/usr/bin/monit restart all -g mongrel"
end

desc <<-DESC
Stop the Mongrel processes on the app server.  This uses the :use_sudo
variable to determine whether to use sudo or not. By default, :use_sudo is
set to true.
DESC
task :stop_mongrel_cluster , :roles => :app do
  sudo "/usr/bin/monit stop all -g mongrel"
end

desc <<-DESC
Start Nginx on the app server.
DESC
task :start_nginx, :roles => :app do
  sudo "/etc/init.d/nginx start"
end

desc <<-DESC
Restart the Nginx processes on the app server by starting and stopping the cluster.
DESC
task :restart_nginx , :roles => :app do
  sudo "/etc/init.d/nginx restart"
end

desc <<-DESC
Stop the Nginx processes on the app server. 
DESC
task :stop_nginx , :roles => :app do
  sudo "/etc/init.d/nginx stop"
end

desc <<-DESC
Tail the nginx logs for this environment
DESC
task :tail_nginx_logs, :roles => :app do
  run "tail -f /var/log/nginx.vhost.access.log" do |channel, stream, data|
    puts "#{channel[:host]}: #{data}" unless data =~ /^10\.0\.0/ # skips lb pull pages
    break if stream == :err    
  end
end

desc <<-DESC
Tail the Rails production log for this environment
DESC
task :tail_production_logs, :roles => :app, :except => {:no_symlink => true} do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err    
  end
end
