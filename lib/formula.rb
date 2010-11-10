module Formula
  
  require 'formula/railtie' if defined?(Rails)
  
  # Default class assigned to input (<div class="input">...</div>).
  mattr_accessor :input_class
  @@input_class = 'input'
  
  # Default class assigned to error (<div class="error">...</div>).
  mattr_accessor :error_class
  @@error_class = 'error'
  
  # Default class assigned to hint (<div class="hint">...</div>).
  mattr_accessor :hint_class
  @@hint_class = 'hint'
  
  # Default tag assigned to input (<div class="input">...</div>).
  mattr_accessor :input_tag
  @@input_tag = :div
  
  # Default tag assigned to error (<div class="error">...</div>).
  mattr_accessor :error_tag
  @@error_tag = :div
  
  # Default tag assigned to hint (<div class="hint">...</div>).
  mattr_accessor :hint_tag
  @@hint_tag = :div
  
  # Default size used on inputs (<input ... size="50" />).
  mattr_accessor :default_input_size
  @@default_input_size = 50
  
  # Default cols used on textarea (<textarea ... cols="50" />).
  mattr_accessor :default_textarea_cols
  @@default_textarea_cols = 50
  
  # Default cols used on textarea (<textarea ... rows="5" />).
  mattr_accessor :default_textarea_rows
  @@default_textarea_rows = 5
  
  class FormulaFormBuilder < ActionView::Helpers::FormBuilder
    
    
    # Generate a suitable form input for a given method by performing introspection on the type. 
    #
    # Options: 
    #
    # * :as    - override the default type used (:url, :email, :phone, :password, :number, :text)
    # * :label - override the default label used ('Name:', 'URL:', etc.)
    # * :error - override the default error used ('invalid', 'incorrect', etc.)
    # * :class - add custom classes to the container ('grid-04', 'grid-08', etc.)
    #
    # Usage:
    #
    #   f.input(:name)
    #   f.input(:email)
    #   f.input(:password_a, :label => "Password", :hint => "It's a secret!", :class => "half")
    #   f.input(:password_b, :label => "Password", :hint => "It's a secret!", :class => "half")
    #
    # Equivalent:
    #
    #   <div>
    #     <div class="input">
    #       <%= f.label(:name)
    #       <%= f.text_field(:name)
    #     </div>
    #   </div>
    #   <div>
    #     <div class="input">
    #       <%= f.label(:email)
    #       <%= f.email_field(:email)
    #     </div>
    #   </div>
    #   <div class="half">
    #     <div class="input">
    #       <%= f.label(:password_a, "Password")
    #       <%= f.password_field(:password_a)
    #       <div class="hint">It's a secret!</div>
    #     </div>
    #   </div>
    #   <div class="half">
    #     <div class="input">
    #       <%= f.label(:password_b, "Password")
    #       <%= f.password_field(:password_b)
    #       <div class="hint">It's a secret!</div>
    #     </div>
    #   </div>
    
    def input(method, options = {})
      options[:as]    ||= as(method)
      options[:error] ||= error(method)
            
      components = []
      
      components << self.label(method, options[:label])
      
      case options[:as]
        when :text     then components << self.text_area(method)
        when :string   then components << self.text_field(method)
        when :password then components << self.password_field(method)
        when :url      then components << self.url_field(method)
        when :email    then components << self.email_field(method)
        when :phone    then components << self.phone_field(method)
        when :number   then components << self.number_field(method)
        when :date     then components << self.date_select(method)
        when :time     then components << self.time_select(method)
        when :datetime then components << self.datetime_select(method)
      end
      
      components << @template.content_tag(::Formula.hint_tag, options[:hint], :class => ::Formula.hint_class) if options[:hint]
      components << @template.content_tag(::Formula.error_tag, options[:error], :class => ::Formula.error_class) if options[:error]
      
      @template.content_tag(:div, :class => options[:class]) do
        @template.content_tag(::Formula.input_tag, :class => ::Formula.input_class) do
          components.join
        end
      end
    end
    
    
    # Generate a suitable form association for a given method by performing introspection on the type. 
    #
    # Options: 
    #
    # * :as    - override the default type used (:url, :email, :phone, :password, :number, :text)
    # * :label - override the default label used ('Name:', 'URL:', etc.)
    # * :error - override the default error used ('invalid', 'incorrect', etc.)
    # * :class - add custom classes to the container ('grid-04', 'grid-08', etc.)
    
    def association(method, options = {}, &block)
    end
    
    
  private
    
    
    # Introspection on the column to determine how to render a method. The method is used to 
    # identify a method type (if the method corresponds to a column)
    #
    # Returns:
    #
    # * :text     - for columns of type 'text'
    # * :string   - for columns of type 'string'
    # * :integer  - for columns of type 'integer'
    # * :float    - for columns of type 'float'
    # * :decimal  - for columns of type 'decimal'
    # * :datetime - for columns of type 'datetime'
    # * :date     - for columns of type 'date'
    # * :time     - for columns of type 'time'
    # * nil       - for unkown columns
  
    def type(method)
      column = @object.column_for_attribute(method) if @object.respond_to?(:column_for_attribute)
      return column.type if column
    end
    
    
    # Introspection on the field and method to determine how to render a method. The method is 
    # used to generate form element types.
    #
    # Returns:
    #
    # * :url      - for columns containing 'url'
    # * :email    - for columns containing 'email'
    # * :phone    - for columns containing 'phone'
    # * :password - for columns containing 'password'
    # * :number   - for integer, float or decimal columns
    # * :datetime - for datetime or timestamp columns
    # * :date     - for date column
    # * :time     - for time column
    # * :text     - for time column
    # * :string   - for all other cases
    
    def as(method)
      type = type(method)
      
      if type == :string or type == nil
        case method
          when /url/      then return :url
          when /email/    then return :email
          when /phone/    then return :phone
          when /password/ then return :password
        end
      end
      
      case type
        when :string    then return :string
        when :integer   then return :number
        when :float     then return :number
        when :decimal   then return :number
        when :timestamp then return :datetime
        when :datetime  then return :datetime
        when :date      then return :date
        when :time      then return :time
        when :text      then return :text
      end
      
      return :string
    end
    
    
    # Generate error messages by combining all errors on an object into a comma seperated string 
    # representation. 
    #
    # Returns:
    #
    # * "name "
    # * :email    - for string columns named 'email'
    # * :phone    - for string columns named 'phone'
    # * :password - for string columns named 'password'
    # * :number   - for integer, float, or decimal columns
    # * :text     - for all other cases
    
    def error(method)
      @object.errors[method].to_sentence
    end
    
  public
    
    def formula_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= self.class
      fields_for(record_or_name_or_array, *(args << options), &block)
    end
  
  end
  
  module FormulaFormHelper
    @@builder = ::Formula::FormulaFormBuilder
    
    
    # Generates a wrapper around form_for with :builder set to FormulaFormBuilder.
    #
    # Supports:
    #
    # * formula_form_for(@user)
    #
    # Equivalent:
    #
    # * form_for(@user, :builder => Formula::FormulaFormBuilder))
    #
    # Usage:
    #
    #   <% formula_form_for(@user) do |f| %>
    #     <%= f.input :email %>
    #     <%= f.input :password %>
    #   <% end %>
    
    alias :formula_for :formula_form_for
    def formula_form_for(record_or_name_or_array, *args, &proc)
       options = args.extract_options!
       options[:builder] ||= @@builder
       form_for(record_or_name_or_array, *(args << options), &proc)
    end
    
    
    # Generates a wrapper around fields_form with :builder set to FormulaFormBuilder.
    #
    # Supports:
    #
    # * f.formula_fields_for(@user.company)
    # * f.fieldsula_for(@user.company)
    #
    # Equivalent:
    #
    # * f.fields_for(@user.company, :builder => Formula::FormulaFormBuilder))
    #
    # Usage:
    #
    #   <% f.formula_form_for(@user.company) do |company_f| %>
    #     <%= company_f.input :url %>
    #     <%= company_f.input :phone %>
    #   <% end %>
    
    alias :fieldsula_for :formula_fields_for 
    def formula_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= @@builder
      fields_for(record_or_name_or_array, *(args << options), &block)
    end
    
  end
  
end