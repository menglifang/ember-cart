Konacha.configure do |config|
  config.spec_dir  = "../javascripts"

  require 'capybara-webkit'
  config.driver    = :webkit
end if defined?(Konacha)
