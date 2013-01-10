source 'http://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'

gem 'mysql2', '>= 0.3'

gem 'haml'
gem 'sass', :tag => '3.0.24'
gem 'kaminari', :git => 'https://github.com/amatsuda/kaminari.git' #for pagination
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'nokogiri'
gem "ckeditor", "3.7.1"
gem "paperclip"
gem 'thin'
gem 'puma'

gem 'acts_as_tree', :git => 'https://github.com/amerine/acts_as_tree.git'

gem "cancan"
gem 'devise'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'progress_bar' # for sunspot

gem 'therubyracer', '0.9.10'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem "ruby-debug-base19x", '>= 0.11.30.pre10'
  gem "ruby-debug-ide", '>= 0.4.17.beta14'
  gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  gem "sextant" # rake routes in the browser
  gem 'bullet'

  gem 'rspec-rails', '>= 2.10.1'
  gem "shoulda-matchers"
  gem "factory_girl_rails", ">= 3.3.0"
end

group :test do
  gem "email_spec", ">= 1.2.1"
  gem 'cucumber-rails', '>= 1.3.0', :require => false
  gem 'capybara', '>= 1.1.2'
  gem 'database_cleaner', '>= 0.7.2'
  gem 'launchy', '>= 2.1.0'
end

gem 'bootstrap-sass', :git => 'https://github.com/thomas-mcdonald/bootstrap-sass.git' #'~> 2.2.1.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0", :require => 'coffee_script'
  gem 'uglifier', '>= 1.0.3'
end

gem 'term-ansicolor'
gem 'exception_notification'
gem 'jsonify-rails'
gem 'yajl-ruby', :require => "yajl" # Required if we want json with utf8 strings

# mp3 info
# require 'open-uri'
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
