source('https://rubygems.org')

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Ruby
ruby '>= 2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# #See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'responders', '~> 2.4'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', '>= 3.1.11'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Breakpoint Debugger, extension to byebug
  gem 'pry-byebug', '~> 3.6'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver', '~> 3.11'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'better_errors', '~> 2.4'
  gem 'binding_of_caller', '~> 0.8.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

source('https://rails-assets.org') do
  # Bootstrap
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-jquery'
  gem 'rails-assets-tether'
  gem 'rails-assets-datetimepicker'
end

# Application YML file configurator, for environment variables
gem 'figaro', '~> 1.1', '>= 1.1.1'

# Composite Primary Keys support for Active Record, Removing this due to error, NameError: undefined local variable or method `always_initialized' for #<ActiveRecord::AttributeSet::Builder:0x00000004dc2c48>
# from (irb)
# gem 'composite_primary_keys'

# Clearance authentication system, however no longer needed
# gem 'clearance'

# Devise authentication system, Active in use
gem 'devise', '~> 4.4', '>= 4.4.3'

# Authorisation with Pundit
gem 'pundit', '~> 1.1'

# Client Side Validations
gem 'client_side_validations', '~> 11.1', '>= 11.1.2'

# Chart helper
gem 'chartkick', '~> 2.3', '>= 2.3.4'

# Nested forms helper
gem 'cocoon', '~> 1.2', '>= 1.2.11'

# For sortable and searchable tables
gem 'rails-assets-DataTables', source: 'https://rails-assets.org'

# Stripe for invoice payment
# gem 'stripe', '~> 3.13'

# BrainTree instead, for PayPal payments
gem 'braintree', '~> 2.88'

# Excel spreadsheet generation, fixme lib/active_support/dependencies.rb:292:in `require': cannot load such file -- zip/zip (LoadError)
# gem 'axlsx'

# Allows to schedule tasks/jobs (Cron)
# gem 'whenever', '~> 0.10.0'

# Allows to schedule tasks/jobs (Redis)
gem 'sidekiq', '~> 5.1', '>= 5.1.3'

# Background work/schedule tasks/jobs (Cron)
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.1'

# Improve console inspection output
gem 'hirb', '~> 0.7.3'

# Refactor
gem 'rails_refactor', '~> 1.4', '>= 1.4.4'
