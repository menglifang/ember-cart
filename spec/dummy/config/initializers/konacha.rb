Konacha.configure do |config|
  config.spec_dir  = "../javascripts"

  # Got errors when using webkit
  #require 'capybara-webkit'
  #config.driver    = :webkit
  config.driver     = :selenium
end if defined?(Konacha)
