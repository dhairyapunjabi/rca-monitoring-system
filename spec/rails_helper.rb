require 'spec_helper'
require 'mongoid-rspec'
require 'support/factory_bot'
require 'database_cleaner'
require 'simplecov'
SimpleCov.refuse_coverage_drop
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include Mongoid::Matchers, type: :model
  config.filter_rails_from_backtrace!
end
