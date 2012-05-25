source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'jquery-rails'

gem 'mysql2', '>= 0.3'

gem 'haml'
gem 'sass', :tag => '3.0.24'
gem 'kaminari', :git => 'https://github.com/amatsuda/kaminari.git' #for pagination
gem 'simple_form', '~> 2.0.0.rc' #:git => 'git://github.com/plataformatec/simple_form.git'
gem "ckeditor", "3.7.0.rc3"
gem 'thin'

gem 'acts_as_tree', :git => 'https://github.com/parasew/acts_as_tree.git'

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
  gem "debugger"
  gem "ruby-debug-ide"
  gem "ruby-debug-base19x", '>=0.11.30.pre7'
  gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  gem "nifty-generators"
  gem 'mongrel', '>= 1.2.0.pre2' #for ruby v1.9.2
  gem "test-unit"
  gem 'bullet'
end

gem 'bootstrap-sass', :git => 'https://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => "2.0"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0"
  gem 'uglifier', '>= 1.0.3'
end

gem 'term-ansicolor'
gem 'exception_notification'
gem 'jsonify-rails'
gem 'yajl-ruby', :require => "yajl" # Required if we want json with utf8 strings
