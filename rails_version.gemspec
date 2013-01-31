# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_version/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jamon Holmgren"]
  gem.email         = ["jamon@clearsightstudio.com"]
  gem.description   = %q{ Pings a server and reports the current app's Rails version. }
  gem.summary       = %q{ Pings a server and reports the current app's Rails version. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.files << "rails.init.rb"
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.name          = "rails_version"
  gem.require_paths = ["lib", "rails"]
  gem.version       = RailsVersion::VERSION
  gem.add_development_dependency 'actionpack'
end
