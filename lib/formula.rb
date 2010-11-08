module Formula
  
  require 'formula/railtie' if defined?(Rails)
  
  class FormulaFormBuilder < ActionView::Helpers::FormBuilder
  
    def input(method, options = {})
    end
  
  end
  
end