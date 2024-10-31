# frozen_string_literal: true

require_relative 'lib/formula/version'

Gem::Specification.new do |spec|
  spec.name        = 'formula'
  spec.version     = Formula::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Kevin Sylvestre']
  spec.email       = ['kevin@ksylvest.com']
  spec.homepage    = 'https://github.com/ksylvest/formula'
  spec.summary     = 'A great way to simplify complex forms'
  spec.description = 'Formula is a Rails form generator that generates simple clean markup. The project aims to let users create semantically beautiful forms without introducing too much syntax. The goal is to make integrating advanced layout systems as simple as possible.'

  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.glob('{bin,lib,exe}/**/*') + %w[README.md Gemfile]

  spec.add_dependency 'rails'
  spec.add_dependency 'zeitwerk'
end
