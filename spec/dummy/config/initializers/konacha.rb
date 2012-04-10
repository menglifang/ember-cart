Konacha.configure do |config|
  config.spec_dir  = "spec/javascripts"
  config.driver    = :webkit
end if defined?(Konacha)
