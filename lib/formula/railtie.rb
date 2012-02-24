require 'formula'
require 'rails'

module Formula
  class Railtie < Rails::Railtie
    initializer 'formula.initialize' do
      ActionView::Base.send :include, Formula::FormulaFormHelper
    end
  end
end
