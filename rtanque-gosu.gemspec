# frozen_string_literal: true

require 'English'
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rtanque/gosu_version'

Gem::Specification.new do |gem|
  gem.name          = 'rtanque-gosu'
  gem.version       = RTanque::Gosu::VERSION
  gem.authors       = ['Joseph Haig', 'Adam Williams']
  gem.email         = ['josephhaig@gmail.com', 'pwnfactory@gmail.com']
  gem.summary       = 'RTanque Gosu is a graphical interface for RTanque using the Gosu library.'
  gem.description   = <<~DESCRIPTION
    RTanque Gosu provides a graphical 'screen' for RTanque using the Gosu library.
    This is the same interface that was built into older versions of RTanque.

    For a full description of the game see the RTanque gem.
  DESCRIPTION
  gem.homepage      = 'https://github.com/jrmhaig/RTanque-gosu'
  gem.license       = 'MIT'
  gem.metadata['rubygems_mfa_required'] = 'true'
  gem.required_ruby_version = '>= 3.2'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']

  gem.add_dependency 'gosu', '~> 1.4.0'
  gem.add_dependency 'rtanque', '~> 0.2.0'
end
