# frozen_string_literal: true

module Formula
  class Config
    # @!attribute [rw] box_options
    #   @return [Hash]
    attr_accessor :box_options

    # @!attribute [rw] area_options
    #   @return [Hash]
    attr_accessor :area_options

    # @!attribute [rw] file_options
    #   @return [Hash]
    attr_accessor :file_options

    # @!attribute [rw] field_options
    #   @return [Hash]
    attr_accessor :field_options

    # @!attribute [rw] select_options
    #   @return [Hash]
    attr_accessor :select_options

    # @!attribute [rw] label_options
    #   @return [Hash]
    attr_accessor :label_options

    # Default class assigned to block (<div class="block">...</div>).
    #
    # @!attribute [rw] block_class
    #   @return [String]
    attr_accessor :block_class

    # Default class assigned to input (<div class="input">...</div>).
    #
    # @!attribute [rw] input_class
    #   @return [String]
    attr_accessor :input_class

    # Default class assigned to association (<div class="association">...</div>).
    #
    # @!attribute [rw] association_class
    #   @return [String]
    attr_accessor :association_class

    # Default class assigned to block with errors (<div class="block errors">...</div>).
    #
    # @!attribute [rw] block_error_class
    #   @return [String]
    attr_accessor :block_error_class

    # Default class assigned to input with errors (<div class="input errors">...</div>).
    #
    # @!attribute [rw] input_error_class
    #   @return [String]
    attr_accessor :input_error_class

    # Default class assigned to input with errors (<div class="association errors">...</div>).
    #
    # @!attribute [rw] association_error_class
    #   @return [String]
    attr_accessor :association_error_class

    # Default class assigned to error (<div class="error">...</div>).
    #
    # @!attribute [rw] error_class
    #   @return [String]
    attr_accessor :error_class

    # Default class assigned to hint (<div class="hint">...</div>).
    #
    # @!attribute [rw] hint_class
    #   @return [String]
    attr_accessor :hint_class

    # Default tag assigned to block (<div class="input">...</div>).
    #
    # @!attribute [rw] block_tag
    #   @return [Symbol]
    attr_accessor :block_tag

    # Default tag assigned to input (<div class="input">...</div>).
    #
    # @!attribute [rw] input_tag
    #   @return [Symbol]
    attr_accessor :input_tag

    # Default tag assigned to association (<div class="association">...</div>).
    #
    # @!attribute [rw] association_tag
    #   @return [Symbol]
    attr_accessor :association_tag

    # Default tag assigned to error (<div class="error">...</div>).
    #
    # @!attribute [rw] error_tag
    #   @return [Symbol]
    attr_accessor :error_tag

    # Default tag assigned to hint (<div class="hint">...</div>).
    #
    # @!attribute [rw] hint_tag
    #   @return [Symbol]
    attr_accessor :hint_tag

    # Default as is :string.
    #
    # @!attribute [rw] default_as
    #   @return [Symbol]
    attr_accessor :default_as

    def initialize
      @box_options = {}
      @area_options = {}
      @file_options = {}
      @field_options = {}
      @select_options = {}
      @label_options = {}
      @block_class = 'block'
      @input_class = 'input'
      @association_class = 'association'
      @block_error_class = 'errors'
      @input_error_class = false
      @association_error_class = false
      @error_class = 'error'
      @hint_class = 'hint'
      @block_tag = :div
      @input_tag = :div
      @association_tag = :div
      @error_tag = :div
      @hint_tag = :div
      @default_as = :string
    end
  end
end
