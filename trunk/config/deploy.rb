# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :use_sudo, false
set :chmod755, %w(app config db lib public vendor script tmp public/dispatch.cgi public/dispatch.fcgi public/dispatch.rb)
set :keep_releases, 3
task :before_deploy do
  cleanup
end
set :application, "daysofaction"
set :repository, "https://svn.radicaldesigns.org/#{application}/trunk"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

role :web, "radical@75.126.58.234"
role :app, "radical@75.126.58.234"
role :db,  "radical@75.126.58.234", :primary => true

# =============================================================================
# OPTIONAL VARIABLES
# =============================================================================
set :deploy_to, "~/apps/daysofaction" # defaults to "/u/apps/#{application}"
# set :user, "flippy"            # defaults to the currently logged in user
# set :scm, :darcs               # defaults to :subversion
# set :svn, "/path/to/svn"       # defaults to searching the PATH
# set :darcs, "/path/to/darcs"   # defaults to searching the PATH
# set :cvs, "/path/to/cvs"       # defaults to searching the PATH
# set :gateway, "gate.host.com"  # default to no gateway

# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25

# =============================================================================
# TASKS
# =============================================================================
# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)

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

# Tasks may take advantage of several different helper methods to interact
# with the remote server(s). These are:
#
# * run(command, options={}, &block): execute the given command on all servers
#   associated with the current task, in parallel. The block, if given, should
#   accept three parameters: the communication channel, a symbol identifying the
#   type of stream (:err or :out), and the data. The block is invoked for all
#   output from the command, allowing you to inspect output and act
#   accordingly.
# * sudo(command, options={}, &block): same as run, but it executes the command
#   via sudo.
# * delete(path, options={}): deletes the given file or directory from all
#   associated servers. If :recursive => true is given in the options, the
#   delete uses "rm -rf" instead of "rm -f".
# * put(buffer, path, options={}): creates or overwrites a file at "path" on
#   all associated servers, populating it with the contents of "buffer". You
#   can specify :mode as an integer value, which will be used to set the mode
#   on the file.
# * render(template, options={}) or render(options={}): renders the given
#   template and returns a string. Alternatively, if the :template key is given,
#   it will be treated as the contents of the template to render. Any other keys
#   are treated as local variables, which are made available to the (ERb)
#   template.

desc "Demonstrates the various helper methods available to recipes."
task :helper_demo do
  # "setup" is a standard task which sets up the directory structure on the
  # remote servers. It is a good idea to run the "setup" task at least once
  # at the beginning of your app's lifetime (it is non-destructive).
  setup

  buffer = render("maintenance.rhtml", :deadline => ENV['UNTIL'])
  put buffer, "#{shared_path}/system/maintenance.html", :mode => 0644
  sudo "killall -USR1 dispatch.fcgi"
  run "#{release_path}/script/spin"
  delete "#{shared_path}/system/maintenance.html"
end

# You can use "transaction" to indicate that if any of the tasks within it fail,
# all should be rolled back (for each task that specifies an on_rollback
# handler).

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
    ln -nfs #{shared_path}/vendor/rflickr-2006.02.01 #{release_path}/vendor/rflickr-2006.02.01
  CMD
end

task :after_symlink, :roles => :app , :except => {:no_symlink => true} do
  run <<-CMD
    cd #{release_path} &&
    ln -nfs #{shared_path}/public/attachments #{release_path}/public/attachments &&
    rake theme_update_cache
  CMD
end 

desc "Set the proper permissions for directories and files on HostingRails accounts"
task :after_deploy do
  run(chmod755.collect do |item|
    "chmod 755 #{current_path}/#{item}"
  end.join(" && "))
end
