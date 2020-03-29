# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lexical_analyzer/version"

Gem::Specification.new do |spec|
  spec.name          = "lexical_analyzer"
  spec.version       = LexicalAnalyzer::VERSION
  spec.authors       = ["PeterCamilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = "The RCTP lexical analyser."
  spec.description   = "The RCTP configurable lexical analyser."
  spec.homepage      = "https://github.com/PeterCamilleri/lexical_analyzer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>=2.3.0'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'reek', "~> 5.0.2"
end
