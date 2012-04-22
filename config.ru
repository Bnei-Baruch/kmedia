# This file is used by Rack-based servers to start the application.
Kmedia::Application.config.middleware.use ExceptionNotifier,
                                            :email_prefix => "[Kmedia] ",
                                            :sender_address => %{"notifier" <notifier@example.com>},
                                            :exception_recipients => %w{gshilin@gmail.com},
                                            :normalize_subject => true

require ::File.expand_path('../config/environment', __FILE__)
run Kmedia::Application
