source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Development and Production use PostgreSQL
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Easier management of different processes
gem 'foreman'
# Use Thin as the app server
gem 'thin'
# Sidekiq for background job processing
gem 'sidekiq'
# Fancy Crontab management
gem 'whenever', :require => false

# Use Bootstrap as our UI framework of choice
gem 'bootstrap-sass', '~> 3.3.4'
# Helper to generate bootstrap forms
gem 'bootstrap_form'
# Easily add 'active' classes to links
gem 'active_link_to'
# Markdown!
gem 'redcarpet'

# Authentication, ho!
gem 'devise'
# And authorization too!
gem 'cancancan', '~> 1.10'
# And then OAuth (2.0 atm) for the API
gem 'doorkeeper'

# Fancy HTTP library
gem 'faraday'
# Wanna scrape HTML
gem 'nokogiri'

# I like my autogenerated admin UIs
gem 'rails_admin'
# And a REST API framework at that
gem 'grape'
gem 'grape-entity'
# With autogenerated documentation
gem 'grape-swagger'
gem 'grape-swagger-ui'
# And OAuth2 authentication
gem 'wine_bouncer'
# Also CanCan authorization
gem 'grape-cancan'
# Prevent ActiveRecord's Strong Parameters from choking on API params
gem 'hashie-forbidden_attributes'

# Send CORS headers
gem 'rack-cors', :require => 'rack/cors'
# Needed for Sidekiq's UI
gem 'sinatra', :require => nil

# Environment variables in a file
# gem 'dotenv-rails'

# Bower packages, yay
source 'https://rails-assets.org' do
  # Fancy select boxes
  gem 'rails-assets-select2', '~> 3.5.2'
  gem 'rails-assets-select2-bootstrap-css'
  
  # Moment.js, sane date/time handling
  gem 'rails-assets-moment'
end

group :development do
  # Use Capistrano for deployment
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  
  # Stop echoing my password
  gem 'highline'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

