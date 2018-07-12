source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'mongoid', '~> 7.0', '>= 7.0.1'
gem 'figaro'
gem 'rubocop', '~> 0.39.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~>4.1.1'
gem 'jquery-rails'
gem 'validates_timeliness-mongoid', github: 'pun97it/date_validator'
gem 'font-awesome-rails'
gem 'jquery-easing-rails', '~> 0.0.2'
gem 'jquery-datatables', '~> 1.10', '>= 1.10.19'
gem 'jquery-ui-rails', github: 'jquery-ui-rails/jquery-ui-rails'
gem 'clockwork', '~> 2.0', '>= 2.0.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'mongoid-rspec', github: 'mongoid/mongoid-rspec'
  gem 'simplecov', require: false
  gem 'database_cleaner'
  gem 'clockwork-test'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
