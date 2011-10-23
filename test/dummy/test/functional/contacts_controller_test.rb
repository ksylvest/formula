require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  
  fixtures :all
  
  setup do
    @contact = contacts(:kevin)
    @avatar = fixture_file_upload("/contacts/avatar.png", "image/png", :binary)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, :id => @contact.id
    assert_response :success
  end
  
  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, :contact => @contact.attributes
    end
    
    assert_redirected_to contacts_path
  end
  
  test "should update contact" do
    post :update, :id => @contact.id, :contact => @contact.attributes
    
    assert_redirected_to contacts_path
  end
  
end
