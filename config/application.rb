require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Masamune
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.autoload_paths += %W(#{config.root}/services)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
