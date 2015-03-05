# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrap_datepicker_spec/version'

Gem::Specification.new do |spec|
  spec.name          = "bootstrap_datepicker_spec"
  spec.version       = BootstrapDatepickerSpec::VERSION
  spec.authors       = ["Chris Rittersdorf"]
  spec.email         = ["chris.rittersdorf@collectiveidea.com"]
  spec.summary       = %q{ Interact with bootstrap-datepicker elements in capybara and RSpec }
  spec.description   = %q{ Interact with bootstrap-datepicker elements in capybara and RSpec }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec", "~> 3.2"
  spec.add_dependency "capybara", "~> 2.4"
  spec.add_dependency "chronic" , "~> 0.10"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
