set :application, "fedena"
set :repository, "git@github.com:ricardo15/fedena.git"
set :scm, "git"

role :web, "server2.railshosting.cz"
role :app, "server2.railshosting.cz"
role :db,  "server2.railshosting.cz", :primary => true

set :deploy_to, "/home/deployer/app/"
set :user, "deployer"
set :use_sudo, false

set :deploy_via, :copy

ssh_options[:port] = 5019

task :after_update_code, :roles => [:app, :db] do
  # link database configuration
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

desc "Stop the webserver on the old release and start the server for the new release"
namespace :deploy do
  task :restart, :roles => :app do
     run "/usr/local/etc/rc.d/mongrel_cluster restart"
  end
end

