# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rtanque/gosu-version'

Gem::Specification.new do |gem|
  gem.name          = "rtanque-gosu"
  gem.version       = RTanque::Gosu::VERSION
  gem.authors       = ["Joseph Haig", "Adam Williams"]
  gem.email         = ["josephhaig@gmail.com", "pwnfactory@gmail.com"]
  gem.summary       = %q{RTanque Gosu is a graphical interface for RTanque using the Gosu library.}
  gem.description   = %q{RTanque Gosu provides a graphical 'screen' for RTanque using the Gosu library. This is the same interface that was built into older
versions of RTanque.

For a full description of the game see the RTanque gem.}
  gem.homepage      = "https://github.com/jrmhaig/RTanque-gosu"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'gosu', '~> 0.13.1'
  gem.add_dependency 'texplay', '>= 0.4.4pre'
  gem.add_dependency 'rtanque', '~> 0.2.0'

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec', '~> 3.7.0'
end
