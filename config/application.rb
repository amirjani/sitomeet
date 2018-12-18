require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Seetomeet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = "Tehran"
    config.active_record.default_timezone = :local
    config.load_defaults 5.2
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    config.generators.javascript_engine = :js
    config.api_only = true
    config.log_level = :info
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
