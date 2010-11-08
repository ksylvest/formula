module Formula
  
  require 'formula/railtie' if defined?(Rails)
  
  class FormulaFormBuilder < ActionView::Helpers::FormBuilder
  
    def input(method, options = {}, &block)
    end
    
    def association(method, options = {}, &block)
    end
    
    def formula_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= self.class
      fields_for(record_or_name_or_array, *(args << options), &block)
    end
  
  end
  
  module FormulaFormHelper
    @@builder = ::Formula::FormulaFormBuilder
    
    def formula_form_for(record_or_name_or_array, *args, &proc)
       options = args.extract_options!
       options[:builder] ||= @@builder
       form_for(record_or_name_or_array, *(args << options), &proc)
    end
     
    def formula_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= @@builder
      fields_for(record_or_name_or_array, *(args << options), &block)
    end

  end
  
end