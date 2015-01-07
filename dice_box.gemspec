# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dice_box/version'

Gem::Specification.new do |spec|
  spec.name          = 'dice_box'
  spec.version       = DiceBox::VERSION
  spec.authors       = ['Rafaël Gonzalez']
  spec.email         = ['github@rafaelgonzalez.me']
  spec.summary       = 'A gem with dices, to get rolling with Ruby.'
  spec.description   = 'A gem with dices, to get rolling with Ruby.'
  spec.homepage      = 'https://github.com/rafaelgonzalez/dice_box'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'yard', '~> 0.8.7'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'simplecov', '~> 0.9.1'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.3'
  spec.add_development_dependency 'cane', '~> 2.6.2'
  spec.add_development_dependency 'rubocop', '~> 0.28.0'
end
