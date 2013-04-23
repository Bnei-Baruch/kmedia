require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile file_assets before deploying to production, use this line
  Bundler.require *Rails.groups(:file_assets => %w(development test)) rescue nil
  # If you want your file_assets lazily compiled in production, use this line
  #Bundler.require(:default, :file_assets, Rails.env)
end

module Kmedia
  class Application < Rails::Application

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your file_assets, change this if you want to expire all your file_assets
    config.assets.version = '1.0'

    config.assets.paths << Rails.root.join('vendor', 'assets')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'projekktor')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into file_assets in config/initializers
    # -- all .rb file_assets in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # JavaScript file_assets you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.jsonify_format = :compile

    config.active_record.schema_format = :sql

    # don't generate RSpec tests for views and helpers
    # we’re using Cucumber scenarios (integration tests)
    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.test_framework :rspec,
                       :fixtures => true,
                       :view_specs => false,
                       :helper_specs => false,
                       :routing_specs => false,
                       :controller_specs => true,
                       :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
  end
end
