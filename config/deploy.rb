require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "fee_finder"
set :scm, :git
set :repository, "johnny@198.61.175.65:repo/fee-finder.git"
set :scm_passphrase, ""
set :user, "johnny"