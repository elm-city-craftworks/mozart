# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mozart/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gregory Brown"]
  gem.email         = ["gregory.t.brown@gmail.com"]
  gem.description   = %q{Tools for making object composition easier}
  gem.summary       = %q{Tools for making object composition easier}
  gem.homepage      = "https://github.com/elm-city-craftworks/mozart"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mozart"
  gem.require_paths = ["lib"]
  gem.version       = Mozart::VERSION
end
