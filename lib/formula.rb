# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

require 'formula/railtie' if defined?(Rails)

module Formula
  # @return [Formula::Config]
  def self.config
    @config ||= Config.new
  end

  # @yield [Formula::Config]
  def self.configure
    yield config
  end
end
