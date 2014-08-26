# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rehab/version'

Gem::Specification.new do |spec|
  spec.name          = "rehab"
  spec.version       = Rehab::VERSION
  spec.license       = "MIT"
  spec.authors       = ["Shane Kuester"]
  spec.email         = ["shout@shanekuester.com"]
  spec.homepage      = "https://github.com/skuester/rehab"
  spec.summary       = %q{Simple, portable template language}
  # spec.description   = %q{Simple, portable template language}

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'tilt'
  spec.add_dependency 'temple'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
end
