require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module RcaMonitoringSystem
  class Application < Rails::Application
    config.load_defaults 5.2
    config.action_view.field_error_proc = Proc.new { |html_tag, instance | html_tag }
  end
end
