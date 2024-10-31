# frozen_string_literal: true

module Formula
  class FormBuilder < ::ActionView::Helpers::FormBuilder
    # Generate a form button.
    #
    # Options:
    #
    # * :container - add custom options to the container
    # * :button    - add custom options to the button
    #
    # Usage:
    #
    #   f.button(:name)
    #
    # Equivalent:
    #
    #   <div class="block">
    #     <%= f.submit("Save")
    #   </div>
    def button(value = nil, options = {})
      options[:button] ||= {}

      options[:container] ||= {}
      options[:container][:class] = arrayorize(options[:container][:class]) << config.block_class

      @template.content_tag(config.block_tag, options[:container]) do
        submit value, options[:button]
      end
    end

    # Basic container generator for use with blocks.
    #
    # Options:
    #
    # * :hint       - specify a hint to be displayed ('We promise not to spam you.', etc.)
    # * :label      - override the default label used ('Name:', 'URL:', etc.)
    # * :error      - override the default error used ('invalid', 'incorrect', etc.)
    #
    # Usage:
    #
    #   f.block(:name, :label => "Name:", :hint => "Please use your full name.", :container => { :class => 'fill' }) do
    #     ...
    #   end
    #
    # Equivalent:
    #
    #   <div class='block fill'>
    #     <%= f.label(:name, "Name:") %>
    #     ...
    #     <div class="hint">Please use your full name.</div>
    #     <div class="error">...</div>
    #   </div>
    def block(method = nil, options = {}, &block)
      options[:error] ||= error(method) if method

      components = ''.html_safe

      components << label(method, options[:label], config.label_options) if method

      components << @template.capture(&block)

      options[:container] ||= {}
      options[:container][:class] = arrayorize(options[:container][:class]) << config.block_class << method
      options[:container][:class] << config.block_error_class if config.block_error_class.present? and error?(method)

      if options[:hint]
        components << @template.content_tag(config.hint_tag, options[:hint],
                                            class: config.hint_class)
      end
      if options[:error]
        components << @template.content_tag(config.error_tag, options[:error],
                                            class: config.error_class)
      end

      @template.content_tag(config.block_tag, options[:container]) do
        components
      end
    end

    # Generate a suitable form input for a given method by performing introspection on the type.
    #
    # Options:
    #
    # * :as         - override the default type used (:url, :email, :phone, :password, :number, :text)
    # * :label      - override the default label used ('Name:', 'URL:', etc.)
    # * :error      - override the default error used ('invalid', 'incorrect', etc.)
    # * :input      - add custom options to the input ({ :class => 'goregous' }, etc.)
    # * :container  - add custom options to the container ({ :class => 'gorgeous' }, etc.)
    #
    # Usage:
    #
    #   f.input(:name)
    #   f.input(:email)
    #   f.input(:password_a, :label => "Password", :hint => "It's a secret!", :container => { :class => "half" })
    #   f.input(:password_b, :label => "Password", :hint => "It's a secret!", :container => { :class => "half" })
    #
    # Equivalent:
    #
    #   <div class="block name">
    #     <%= f.label(:name)
    #     <div class="input string"><%= f.text_field(:name)</div>
    #      <div class="error">...</div>
    #   </div>
    #   <div class="block email">
    #     <%= f.label(:email)
    #     <div class="input string"><%= f.email_field(:email)</div>
    #      <div class="error">...</div>
    #   </div>
    #   <div class="block half password_a">
    #     <div class="input">
    #       <%= f.label(:password_a, "Password")
    #       <%= f.password_field(:password_a)
    #       <div class="hint">It's a secret!</div>
    #       <div class="error">...</div>
    #     </div>
    #   </div>
    #   <div class="block half password_b">
    #     <div class="input">
    #       <%= f.label(:password_b, "Password")
    #       <%= f.password_field(:password_b)
    #       <div class="hint">It's a secret!</div>
    #       <div class="error">...</div>
    #     </div>
    #   </div>
    def input(method, options = {})
      options[:as] ||= as(method)
      options[:input] ||= {}

      return hidden_field method, options[:input] if options[:as] == :hidden

      klass = [config.input_class, options[:as]]
      klass << config.input_error_class if config.input_error_class.present? and error?(method)

      block(method, options) do
        @template.content_tag(config.input_tag, class: klass) do
          case options[:as]
          when :text     then text_area       method, config.area_options.merge(options[:input] || {})
          when :file     then file_field      method, config.file_options.merge(options[:input] || {})
          when :string   then text_field      method, config.field_options.merge(options[:input] || {})
          when :password then password_field  method, config.field_options.merge(options[:input] || {})
          when :url      then url_field       method, config.field_options.merge(options[:input] || {})
          when :email    then email_field     method, config.field_options.merge(options[:input] || {})
          when :phone    then phone_field     method, config.field_options.merge(options[:input] || {})
          when :number   then number_field    method, config.field_options.merge(options[:input] || {})
          when :boolean  then check_box       method, config.box_options.merge(options[:input] || {})
          when :country  then country_select  method, config.select_options.merge(options[:input] || {})
          when :date     then date_select     method, config.select_options.merge(options[:input] || {}),
                                              options[:input].delete(:html) || {}
          when :time     then time_select     method, config.select_options.merge(options[:input] || {}),
                                              options[:input].delete(:html) || {}
          when :datetime then datetime_select method, config.select_options.merge(options[:input] || {}),
                                              options[:input].delete(:html) || {}
          when :select   then select          method, options[:choices],
                                              config.select_options.merge(options[:input] || {}), options[:input].delete(:html) || {}
          end
        end
      end
    end

    # Generate a suitable form association for a given method by performing introspection on the type.
    #
    # Options:
    #
    # * :label       - override the default label used ('Name:', 'URL:', etc.)
    # * :error       - override the default error used ('invalid', 'incorrect', etc.)
    # * :association - add custom options to the input ({ :class => 'goregous' }, etc.)
    # * :container   - add custom options to the container ({ :class => 'gorgeous' }, etc.)
    #
    # Usage:
    #
    #   f.association(:category, Category.all, :id, :name, :hint => "What do you do?")
    #   f.association(:category, Category.all, :id, :name, :association => { :prompt => "Category?" })
    #   f.association(:category, Category.all, :id, :name, :association => { :html => { :class => "category" } })
    #
    # Equivalent:
    #
    #   <div>
    #     <div class="association category">
    #       <%= f.label(:category)
    #       <div class="association">
    #         <%= f.collection_select(:category, Category.all, :id, :name) %>
    #       </div>
    #       <div class="hint">What do you do?</div>
    #       <div class="error">...</div>
    #     </div>
    #   </div>
    #   <div>
    #     <div class="association category">
    #       <%= f.label(:category)
    #       <div class="association">
    #         <%= f.collection_select(:category, Category.all, :id, :name, { :prompt => "Category") } %>
    #       </div>
    #       <div class="error">...</div>
    #     </div>
    #   </div>
    #   <div>
    #     <div class="association category">
    #       <%= f.label(:category)
    #       <div class="association">
    #         <%= f.collection_select(:category, Category.all, :id, :name, {}, { :class => "category" } %>
    #       </div>
    #       <div class="error">...</div>
    #     </div>
    #   </div>
    def association(method, collection, value, text, options = {})
      options[:as] ||= :select
      options[:association] ||= {}

      klass = [config.association_class, options[:as]]
      klass << config.association_error_class if config.association_error_class.present? and error?(method)

      block(method, options) do
        @template.content_tag(config.association_tag, class: klass) do
          case options[:as]
          when :select then collection_select :"#{method}_id", collection, value, text,
                                              options[:association], options[:association].delete(:html) || {}
          end
        end
      end
    end

    private

    def config
      ::Formula.config
    end

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
      return unless @object.respond_to?(:has_attribute?) && @object.has_attribute?(method)

      column = @object.column_for_attribute(method) if @object.respond_to?(:column_for_attribute)
      column.type if column
    end

    # Introspection on an association to determine if a method is a file. This
    # is determined by the methods ability to respond to file methods.
    def file?(method)
      @files ||= {}
      @files[method] ||= begin
        file = @object.send(method) if @object && @object.respond_to?(method)
        file.is_a?(::ActiveStorage::Attached)
      end
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
      case "#{method}"
      when /url/      then return :url
      when /email/    then return :email
      when /phone/    then return :phone
      when /password/ then return :password
      end

      case type(method)
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

      return :file if file?(method)

      config.default_as
    end

    # Generate error messages by combining all errors on an object into a comma seperated string
    # representation.
    def error(method)
      errors = @object.errors[method] if @object
      errors.to_sentence if errors.present?
    end

    # Identify if error message exists for a given method by checking for the presence of the object
    # followed by the presence of errors.
    def error?(method)
      @object.present? and @object.errors[method].present?
    end

    # Create an array from a string, a symbol, or an undefined value. The default is to return
    # the value and assume it has already is valid.
    def arrayorize(value)
      case value
      when nil    then []
      when String then value.to_s.split
      when Symbol then value.to_s.split
      else value
      end
    end

    public

    # Generates a wrapper around fields_form with :builder set to FormBuilder.
    #
    # Supports:
    #
    # * f.formula_fields_for(@user.company)
    # * f.fieldsula_for(@user.company)
    #
    # Equivalent:
    #
    # * f.fields_for(@user.company, builder: Formula::FormBuilder))
    #
    # Usage:
    #
    #   <% f.formula_fields_for(@user.company) do |company_f| %>
    #     <%= company_f.input :url %>
    #     <%= company_f.input :phone %>
    #   <% end %>
    def formula_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= self.class
      fields_for(record_or_name_or_array, *(args << options), &block)
    end

    alias fieldsula_for formula_fields_for
  end
end
