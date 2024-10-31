# frozen_string_literal: true

require 'test_helper'

class ContactFormTest < ActionDispatch::IntegrationTest
  def setup
    @group = Group.new(name: 'Developer')
    @group.save!
  end

  test 'contact form' do
    post contacts_path, params: {
      contact: { name: '' },
    }

    assert_response 422

    assert_select('.details') do
      assert_select('.input.text') do
        assert_select('textarea')
      end
      assert_select('label', 'Details')
      assert_select('.hint', 'a detailed description')
      assert_select('.error', "can't be blank")
    end

    assert_select('.name') do
      assert_select('.input.string') do
        assert_select('input[type=text]')
      end
      assert_select('label', 'Name')
      assert_select('.hint', 'first and last name')
      assert_select('.error', "can't be blank")
    end

    assert_select('.email') do
      assert_select('.input.email') do
        assert_select('input[type=email]')
      end
      assert_select('label', 'Email')
      assert_select('.hint', 'sample@example.com')
      assert_select('.error', "can't be blank and is not valid")
    end

    assert_select('.phone') do
      assert_select('.input.phone') do
        assert_select('input[type=tel]')
      end
      assert_select('label', 'Phone')
      assert_select('.hint', '+01 (555) 555-5555')
      assert_select('.error', "can't be blank and is not valid")
    end

    assert_select('.url') do
      assert_select('.input.url') do
        assert_select('input[type=url]')
      end
      assert_select('label', 'Website')
      assert_select('.hint', 'http://example.com/')
      assert_select('.error', "can't be blank")
    end

    assert_select('.avatar') do
      assert_select('.input.file') do
        assert_select('input[type=file]')
      end
      assert_select('label', 'Avatar')
    end

    assert_select('.group') do
      assert_select('.association.select') do
        assert_select('select') do
          assert_select('option', 'Developer')
        end
      end
      assert_select('.error', 'must exist')
      assert_select('label', 'Group')
    end

    assert_select('.errors.name', true, 'Name block should have "errors" class')
    assert_select('.errors.details', true, 'Details block should have "errors" class')
  end
end
