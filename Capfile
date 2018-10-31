set :user, 'deployer'
# set :domain, 'jellly.com'

default_run_options[:pty] = true

# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
require 'capistrano/passenger'
install_plugin Capistrano::Puma
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma::Nginx
install_plugin Capistrano::Puma::Jungle
require 'capistrano/nginx'
require 'capistrano/upload-config'
require 'sshkit/sudo'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

# ssh_keys from github
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
# set :ssh_options, {:forward_agent => true}
# set :deploy_via, :copy

