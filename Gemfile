# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# env thing
gem 'dotenv-rails', groups: %i[development test], require: 'dotenv/rails-now'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0.beta2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use postgres
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :ruby

  # Fuck minitest
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rspec'
  gem 'rspec-rails', '~> 3.5'

  gem 'simplecov'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'

  gem 'letter_opener'
  gem 'net_http_ssl_fix', require: 'net_http_ssl_fix'
  gem 'rubocop'
  gem 'slim_lint'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'carrierwave', '~> 1.0'
gem 'country_select'
gem 'devise'
gem 'devise_uid'
gem 'friendly_id', '~> 5.2.0'
gem 'http_accept_language'
gem 'it'
gem 'jquery-minicolors-rails'
gem 'kaminari'
gem 'local_time', git: 'https://github.com/basecamp/local_time', branch: '2-0'
gem 'mini_magick'
gem 'omniauth-facebook'
gem 'slim-rails'
gem 'validates_serialized'
