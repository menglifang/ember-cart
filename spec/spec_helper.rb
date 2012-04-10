# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'ffaker'
require 'factory_girl_rails'
require 'shoulda-matchers'
require 'pry'
require 'rack_session_access'
require 'rack_session_access/capybara'
require 'json_spec'

# Set up capybara
require 'capybara/rails'
require 'capybara-webkit'
Capybara.javascript_driver = :webkit

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  # Mixin routes helpers
  config.include EmberCart::Engine.routes.url_helpers

  # Mixin factory_girl methods
  config.include FactoryGirl::Syntax::Methods

  # Mixin json_spec helpers
  config.include JsonSpec::Helpers

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end
