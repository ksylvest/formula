module Formula
  
  require 'formula/railtie' if defined?(Rails)
  
  mattr_accessor :container_tag
  @@container_tag = :div
  
  mattr_accessor :hints_tag
  @@hints_tag = :div
  
  mattr_accessor :errors_tag
  @@errors_tag = :div
  
  mattr_accessor :default_input_size
  @@default_input_size = 50
  
  mattr_accessor :default_textarea_cols
  @@default_textarea_cols = 50
  
  mattr_accessor :default_textarea_rows
  @@default_textarea_rows = 3
  
  class FormulaFormBuilder < ActionView::Helpers::FormBuilder
    
    def as(method, options = {})
      type = @object.column_for_attribute(method)
      
      case type
        when :string then
          return :url       if method.to_s =~ /url/
          return :email     if method.to_s =~ /email/
          return :phone     if method.to_s =~ /phone/
          return :password  if method.to_s =~ /password/
        when :integer then
          return :number
        when :float   then
          return :number
        when :decimal then
          return :number
      end
      
      return :text
    end
  
    def input(method, options = {}, &block)
      options[:as] ||= as(method, options)
      options[:errors] ||= @object.errors[method]
      
      components = []
      
      components << label(:method, options[:label])
      components << @template.content_tag(::Formula.hints_tag, options[:hint], :class => 'hints') if options[:hints]
      components << @template.content_tag(::Formula.errors_tag, options[:errors], :class => 'errors') if options[:errors]
      
      @template.content_tag(::Formula.container_tag, :class => options[:class]) do
        components.join
      end
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
    
    alias :formula_for :formula_form_for
    alias :fieldula_for :formula_fields_for
  end
  
end