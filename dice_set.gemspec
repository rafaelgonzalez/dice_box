# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dice_set/version'

Gem::Specification.new do |spec|
  spec.name          = 'dice_set'
  spec.version       = DiceSet::VERSION
  spec.authors       = ['Rafaël Gonzalez']
  spec.email         = ['github@rafaelgonzalez.me']
  spec.summary       = %q{A gem with dices, to get rolling with Ruby.}
  spec.description   = %q{A gem with dices, to get rolling with Ruby.}
  spec.homepage      = 'https://github.com/rafaelgonzalez/dice_set'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
