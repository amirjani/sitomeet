# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :ssh_options, {:forward_agent => true}
set :application, "SitOMeet"
set :repo_url,    "git@github.com:amirjani/sitomeet.git"
set :user,        "deployer"

server '31.184.135.21', user: "#{fetch(:user)}" , roles: %w{app db web} , primary: true

set :deploy_to, "/home/deployer/sitomeet"
set :pty,             true

append :linked_files, "config/database.yml", "config/secrets.yml" , "config/puma.rb"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

set :config_example_suffix, '.example'
set :config_files, %w{config/database.yml config/secrets.yml}
set :puma_conf, "#{shared_path}/config/puma.rb"

namespace :deploy do
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:jungle:setup'
  before 'check:linked_files', 'puma:nginx_config'
  after 'puma:smart_restart', 'nginx:restart'
end



