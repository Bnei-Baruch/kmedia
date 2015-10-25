#Kmedia::Application.config.middleware.use ExceptionNotification::Rack,
                      #email: {
                          #email_prefix: '[Kmedia] ',
                          #sender_address: %{'notifier' <notifier@kmedia.com>},
                          #exception_recipients: %w{gshilin@gmail.com},
                          #normalize_subject: true
                      #}

Kmedia::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = false

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = 'X-Sendfile'

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug
  config.logger = Logger.new("log/#{Rails.env}.log", 8, 4 * 1024**2)

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  config.cache_store = :dalli_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = true

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Compress JavaScript and CSS
  config.assets.compress = true

  # Reuse previous results from cache
  config.assets.cache_store = :dalli_store

  # Don't fallback to assets pipeline
  config.assets.compile = true
  config.assets.precompile += %w( admin.js user.js )
  config.assets.precompile += %w( admin.css user.css )

  # Generate digests for assets URLs
  config.assets.digest = true

  # config.i18n.available_locales = Language::UI_LANGUAGES
end
