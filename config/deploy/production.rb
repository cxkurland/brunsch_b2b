# Settings for staging server
server 'ec2-54-93-84-126.eu-central-1.compute.amazonaws.com', :app, :web, :db, :primary => true
set :rails_env, 'production'

set :use_sudo, false
set :deploy_via, :remote_cache
set :user, 'w3villa'
set :rvm_ruby_version, 'ruby-2.1.0'
set :deploy_to, "/home/#{user}/#{application}"
set :branch, 'master'