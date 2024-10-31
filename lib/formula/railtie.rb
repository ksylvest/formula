# frozen_string_literal: true

require 'rails'

module Formula
  class Railtie < Rails::Railtie
    initializer 'formula.initialize' do
      ActionView::Base.include Formula::FormulaFormHelper
    end
  end
end
