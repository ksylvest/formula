# frozen_string_literal: true

require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @group = Group.new(name: 'Developer')
    @group.save!
    @contact = Contact.new(
      group: @group,
      name: 'Kevin',
      details: 'Me',
      phone: '555-555-5555',
      email: 'me@ksylvest.com',
      url: 'https://ksylvest.com'
    )
    @contact.save!
  end

  test 'should get index' do
    get contacts_url
    assert_response :success
  end

  test 'should get new' do
    get new_contact_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_contact_url(@contact)
    assert_response :success
  end

  test 'should create contact' do
    assert_difference('Contact.count') do
      post contacts_url, params: {
        contact: {
          group_id: @contact.group.id,
          name: @contact.name,
          details: @contact.details,
          phone: @contact.phone,
          email: @contact.email,
          url: @contact.url,
        },
      }
    end

    assert_redirected_to contacts_path
  end

  test 'should update contact' do
    patch contact_url(@contact), params: {
      contact: {
        group_id: @group.id,
        name: @contact.name,
        details: @contact.details,
        phone: @contact.phone,
        email: @contact.email,
        url: @contact.url,
      },
    }

    assert_redirected_to contacts_path
  end
end
