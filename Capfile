# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# This will add tasks to your deploy process
require "capistrano/rails"
require "capistrano/passenger"
require "capistrano/rbenv"
require "capistrano/yarn"
require "capistrano/bundler"

set :rbenv_type, :user
set :rbenv_ruby, "2.3.3"

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
