# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "formula/version"

Gem::Specification.new do |s|
  s.name        = "formula"
  s.version     = Formula::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin Sylvestre"]
  s.email       = ["kevin@ksylvest.com"]
  s.homepage    = "http://github.com/ksylvest/formula"
  s.summary     = "A great way to simplify complex forms"
  s.description = "Formula is a Rails form generator that generates simple clean markup. The project aims to let users create semantically beautiful forms without introducing too much syntax. The goal is to make integrating advanced layout systems as simple as possible."

  s.files       = Dir["{bin,lib}/**/*"] + %w(LICENSE Rakefile README.rdoc)
  s.test_files  = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.0.0"
  s.add_development_dependency "appraisal"
end
