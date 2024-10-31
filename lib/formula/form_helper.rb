# frozen_string_literal: true

module Formula
  module FormHelper
    # Generates a wrapper around form_for with :builder set to Formula::FormBuilder.
    #
    # Supports:
    #
    # * formula_form_for(@user)
    #
    # Equivalent:
    #
    # * form_for(@user, builder: Formula::FormBuilder))
    #
    # Usage:
    #
    #   <% formula_form_for(@user) do |f| %>
    #     <%= f.input :email %>
    #     <%= f.input :password %>
    #   <% end %>
    def formula_form_for(record_or_name_or_array, *args, &proc)
      options = args.extract_options!
      options[:builder] ||= ::Formula::FormBuilder
      form_for(record_or_name_or_array, *(args << options), &proc)
    end

    # Generates a wrapper around fields_for with :builder set to Formula::FormBuilder.
    #
    # Supports:
    #
    # * f.formula_fields_for(@user.company)
    #
    # Equivalent:
    #
    # * f.fields_for(@user.company, builder: Formula::FormulaFormBuilder))
    #
    # Usage:
    #
    #   <% f.formula_fields_for(@user.company) do |company_f| %>
    #     <%= company_f.input :url %>
    #     <%= company_f.input :phone %>
    #   <% end %>
    def formula_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= ::Formula::FormBuilder
      fields_for(record_or_name_or_array, *(args << options), &block)
    end
  end
end
