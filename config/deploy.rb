require 'capistrano/ext/multistage'
require "capistrano/node-deploy"

# role :app, "feefinder.org"

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "fee-finder"
set :scm, :git
set :repository, "johnny@198.61.175.65:repo/fee-finder.git"
set :scm_passphrase, "29483270"
set :user, "johnny"
set :ssh_key, "id_rsa"
# set :use_sudo, true
default_run_options[:pty] = true
# set :ssh_options, { :forward_agent => true }
# set :deploy_via, :remote_cache


# Set app command to run (defaults to index.js, or your `main` file from `package.json`)
set :app_command, "app/app.js"

# Set additional environment variables for the app
set :app_environment, "PORT=8080"

# Set node binary to run (defaults to /usr/bin/node)
set :node_binary, "~/node/bin/node"

# Set node environment (defaults to production)
set :node_env, "staging"

# Set the user to run node as (defaults to deploy)
set :node_user, "johnny"

# Set the name of the upstart command (defaults to #{application}-#{node_env})
# set :upstart_job_name, "myserver"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end