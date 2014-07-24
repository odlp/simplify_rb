# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplify_rb/version'

Gem::Specification.new do |spec|
  spec.name          = "simplify_rb"
  spec.version       = SimplifyRb::VERSION
  spec.authors       = ["odlp"]
  spec.description   = "Polyline simplification library. Ruby port of Simplify.js."
  spec.summary       = "Polyline simplification library. Ruby port of Simplify.js."
  spec.homepage      = "https://github.com/odlp/simplify_rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
