require 'test_helper'

class FormulaTest < ActiveSupport::TestCase
  test "formula is a module" do
    assert_kind_of Module, Formula
  end
end
