# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'micro/version'

Gem::Specification.new do |spec|
  spec.name          = 'micromvc'
  spec.version       = Micro::VERSION
  spec.authors       = ['Ashley Towns']
  spec.email         = ['ashleyis@me.com']
  spec.summary       = %q{a tiny micro mvc framework}
  spec.description   = %q{a tiny opinionated micro mvc framework, this is a toy}
  spec.homepage      = 'http://github.com/aktowns/micromvc'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rack', '~> 1.5'
  spec.add_runtime_dependency 'tilt', '~> 2.0'
  spec.add_runtime_dependency 'rack-unreloader', '~> 0'
  spec.add_runtime_dependency 'awesome_print', '~> 0'
  spec.add_runtime_dependency 'better_errors', '~> 0'
  spec.add_runtime_dependency 'binding_of_caller', '~> 0'
  spec.add_runtime_dependency 'sequel', '~> 0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0'
end
