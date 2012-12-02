# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest-descriptive/version'

Gem::Specification.new do |gem|
  gem.name          = "minitest-descriptive"
  gem.version       = MiniTest::Descriptive::VERSION
  gem.authors       = ["Josep M. Bach"]
  gem.email         = ["josep.m.bach@gmail.com"]
  gem.description   = %q{Make your assertion diffs smarter}
  gem.summary       = %q{Make your assertion diffs smarter}
  gem.homepage      = "https://github.com/txus/minitest-descriptive"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "minitest"
end
