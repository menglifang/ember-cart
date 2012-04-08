$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ember-cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ember-cart"
  s.version     = EmberCart::VERSION
  s.authors     = ["Tower He"]
  s.email       = ["towerhe@gmail.com"]
  s.homepage    = "https://github.com/ichid/ember-cart"
  s.summary     = "ember-cart provides a common cart for e-commerce sites."
  s.description = "ember-cart a rails mountable engine which provides a cart solution for e-commerce sites. It is deeply inspired by rightnow_oms and its front side is created based on ember and ember-data."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mysql2"
end
