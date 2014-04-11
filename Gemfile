source 'http://rubygems.org'

gem 'rails', '3.2.16'
gem 'jquery-rails'

gem 'mysql2', '>= 0.3'

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

gem 'the_sortable_tree', github: 'the-teacher/the_sortable_tree'

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
  gem 'zeus'
end

group :test do
  #gem 'rspec-rails', '>= 2.10.1'
  #gem 'shoulda-matchers'
  #gem 'factory_girl_rails', '>= 3.3.0'
  #gem 'guard-rspec'
  #gem 'rb-inotify', '~> 0.8.8'
  #gem 'simplecov', :require => false
#  gem 'email_spec', '>= 1.2.1'
#  gem 'cucumber-rails', '>= 1.3.0', :require => false
#  gem 'capybara', '>= 1.1.2'
#  gem 'database_cleaner', '>= 0.7.2'
#  gem 'launchy', '>= 2.1.0'
end

gem 'bootstrap-sass', '~> 2.3.2.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.2.0', :require => 'coffee_script'
  gem 'uglifier', '>= 1.0.3'
end

gem 'term-ansicolor', github: 'flori/term-ansicolor'
gem 'exception_notification', github: 'smartinez87/exception_notification'
gem 'jsonify-rails'
gem 'yajl-ruby', :require => 'yajl' # Required if we want json with utf8 strings

gem 'newrelic_rpm'

# mp3 info
require 'open-uri'
# m = Mp3Info.open(open('http://files.kabbalahmedia.info/audio/rus_t_rav_achana_2012-11-21_lesson.mp3'))
# m.length # in seconds
gem 'ruby-mp3info', :require => 'mp3info'

# wma/wmv/asf info
# f = WmaInfo.new('data/3.wmv')
# f.info['playtime_seconds']
gem 'moumar-wmainfo-rb', :git => 'https://github.com/moumar/wmainfo-rb.git', :require => 'wmainfo'

#gem 'mp4info', git: 'git://github.com/arbarlow/ruby-mp4info.git', require: 'mp4info'
# info = MP4Info.open('data/4.mp4')
# info.SECS or "#{info.MM}:#{info.SS}.#{info.MS}"

# antiword - to extract text from .doc file
