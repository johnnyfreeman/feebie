require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "fee-finder"
set :scm, :git
set :repository, "johnny@198.61.175.65:repo/fee-finder.git"
set :scm_passphrase, "29483270"
set :user, "johnny"
# set :ssh_key, "id_rsa"
# set :use_sudo, true
default_run_options[:pty] = true
# set :ssh_options, { :forward_agent => true }
# set :deploy_via, :remote_cache