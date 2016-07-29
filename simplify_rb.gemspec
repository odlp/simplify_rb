# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplify_rb/version'

Gem::Specification.new do |spec|
  spec.name          = "simplify_rb"
  spec.version       = SimplifyRb::VERSION
  spec.authors       = ["odlp"]
  spec.description   = "You can use this gem to reduce the number of points in a complex polyline / polygon, making use of an optimized Douglas-Peucker algorithm. Ruby port of Simplify.js."
  spec.summary       = "Polyline simplification library. Ruby port of Simplify.js."
  spec.homepage      = "https://github.com/odlp/simplify_rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11"
  spec.add_development_dependency "rspec", "~> 3.5"
end
