# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    config.load_defaults '7.2'

    config.autoload_lib(ignore: %w[assets tasks])
  end
end
