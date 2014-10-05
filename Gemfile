source 'http://rubygems.org'

gem 'rails', '3.2.18'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-3-x'
gem 'jquery-rails'
gem 'jquery-ui-rails', github: 'joliss/jquery-ui-rails'
gem 'pg'

gem 'haml'
gem 'sass'
gem 'kaminari', github: 'amatsuda/kaminari' #for pagination
gem 'simple_form', github: 'plataformatec/simple_form', branch: 'v2.1'
gem 'nokogiri'
gem 'ckeditor', '3.7.1'
gem 'paperclip'
gem 'thin'
gem 'puma'
gem 'unicorn'
gem 'slim'

gem 'acts_as_tree', github: 'amerine/acts_as_tree'

gem 'cancan', '1.6.9'
gem 'devise', '2.2.3'
gem 'sunspot_rails', '2.0.0'
gem 'sunspot_solr', '2.0.0'
gem 'progress_bar', github: 'paul/progress_bar' # for sunspot
gem 'best_in_place'
gem 'therubyracer', '0.11.4'
gem 'dalli'
gem 'delayed_job_active_record'
gem 'rakismet', github: 'joshfrench/rakismet'
gem 'the_sortable_tree', github: 'the-teacher/the_sortable_tree'
gem 'draper', '~> 1.3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'debugger'
  gem 'debugger-xml'
  gem 'sextant' # rake routes in the browser
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rb-fsevent', '~> 0.9'
  gem 'terminal-notifier-guard'
  gem 'guard-minitest'
end

group :test do
  gem 'minitest-rails'
  gem 'minitest-rails-capybara'
  gem 'shoulda'
  gem 'minitest-reporters'
  gem 'factory_girl_rails'
  gem 'mocha', require: false
end

gem 'bootstrap-sass', '~> 2.3.2.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.2.0', require:  'coffee_script'
  gem 'uglifier', '>= 1.0.3'
end

gem 'term-ansicolor', github: 'flori/term-ansicolor'
gem 'exception_notification', github: 'smartinez87/exception_notification'
gem 'handle_invalid_percent_encoding_requests', github: 'gshilin/handle_invalid_percent_encoding_requests'
gem 'jsonify-rails'
gem 'yajl-ruby', require:  'yajl' # Required if we want json with utf8 strings

gem 'rake', '~> 10.3.1'
# gem 'newrelic_rpm'

# mp3 info
require 'open-uri'
# m = Mp3Info.open(open('http://files.kabbalahmedia.info/audio/rus_t_rav_achana_2012-11-21_lesson.mp3'))
# m.length # in seconds
gem 'ruby-mp3info', require:  'mp3info'

# wma/wmv/asf info
# f = WmaInfo.new('data/3.wmv')
# f.info['playtime_seconds']
gem 'wmainfo-rb', github: 'moumar/wmainfo-rb', require:  'wmainfo'

# info = MP4Info.open('data/4.mp4')
# info.SECS or "#{info.MM}:#{info.SS}.#{info.MS}"
gem 'mp4info', git: 'git://github.com/arbarlow/ruby-mp4info.git', require: 'mp4info'

# antiword - to extract text from .doc file
