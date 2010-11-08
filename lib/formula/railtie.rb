require 'formula'
require 'rails'

module Formula
  class Railtie < Rails::Railtie
    initializer 'formula.initialize' do
    end
  end
end