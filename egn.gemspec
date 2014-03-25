# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'egn/version'

Gem::Specification.new do |spec|
  spec.name          = "egn"
  spec.version       = Egn::VERSION
  spec.authors       = ["gmitrev"]
  spec.email         = ["gvmitrev@gmail.com"]
  spec.description   = %q{Generator, validator and info parser for EGN numbers}
  spec.summary       = %q{An easy way to generate and validate EGN numbers and parse them for useful information}
  spec.homepage      = "https://github.com/gmitrev/egn"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "coveralls"
end
