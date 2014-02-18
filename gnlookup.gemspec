$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gnlookup/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gnlookup"
  s.version     = Gnlookup::VERSION
  s.authors     = ["Lei Wang"]
  s.email       = ["lei.wang@yale.edu"]
  s.homepage    = "http://library.medicine.yale.edu/"
  s.summary     = "Gnlookup integrates free geolocation data from geonames.org to your Ruby on Rails application."
  s.description = "Gnlookup allows you to integrate free city-level geolocation data from geonames.org to your Ruby on Rails application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.16"
  s.add_development_dependency "sqlite3"
end
