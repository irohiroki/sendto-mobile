require 'rubygems'
require 'spork'
require File.expand_path("../spork-ruby-debug", __FILE__)

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true

    config.include(AppSpecHelper)

    ActiveSupport::Dependencies.clear
  end

  Webrat.configure do |config|
    config.mode = :rack
    config.open_error_files = false
  end
end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| load f}

  SendtoMobile::Application.reload_routes!
end
