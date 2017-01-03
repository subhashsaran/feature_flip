# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "feature_flip/version"

Gem::Specification.new do |s|
  s.name        = "feature_flip"
  s.version     = FeatureFlip::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Subhash"]
  s.email       = ["subhash.rubyist@gmail.com"]
  s.homepage    = "https://github.com/subhashsaran/feature_flip"
  s.summary     = %q{A feature flipper for Rails web applications.}
  s.description = %q{Declarative API for specifying features, switchable in declaration, database and cookies.}
  s.license  = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("activesupport", ">= 4.0", "<= 5.2")
  s.add_dependency("i18n")

  s.add_development_dependency("actionpack")
  s.add_development_dependency("rspec", "~> 3.5")
  s.add_development_dependency("rspec-its")
  s.add_development_dependency("rake")
end
