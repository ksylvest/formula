require 'test_helper'

class ContactFormTest < ActionDispatch::IntegrationTest
  
  fixtures :all
  
  test "contact form" do
    
    post_via_redirect "/contacts"
    
    assert_response :success
    
    assert_select(".block.details") do
      assert_select(".input.text") do
        assert_select("textarea")
      end
      assert_select("label", "Details")
      assert_select(".hint", "a detailed description")
      assert_select(".error", "can't be blank")
    end
    
    assert_select(".block.with_errors.details", {:count => 1}, 'Details block should has "with_errors" class.')
    
    assert_select(".block.name") do
      assert_select(".input.string") do
        assert_select("input[type=text]")
      end
      assert_select("label", "Name")
      assert_select(".hint", "first and last name")
      assert_select(".error", "can't be blank")
    end
    
    assert_select(".block.with_errors.name", {:count => 1}, 'Name block should has "with_errors" class.')
    
    assert_select(".block") do
      assert_select(".input.email") do
        assert_select("input[type=email]")
      end
      assert_select("label", "Email")
      assert_select(".hint", "sample@example.com")
      assert_select(".error", "can't be blank and is not valid")
    end
    
    assert_select('.block.email', false, 'Class "email" should not be added to block')
    
    assert_select(".block") do
       assert_select(".input.phone") do
         assert_select("input[type=tel]")
       end
       assert_select("label", "Phone")
       assert_select(".hint", "+01 (555) 555-5555")
       assert_select(".error", "can't be blank and is not valid")
     end
    
    assert_select('.block.phone', false, 'Class "phone" should not be added to block')
    
    assert_select(".block") do
      assert_select(".input.url") do
        assert_select("input[type=url]")
      end
      assert_select("label", "Website")
      assert_select(".hint", "http://example.com/")
      assert_select(".error", "can't be blank")
    end
    
    assert_select('.block.url', false, 'Class "url" should not be added to block')
    
    assert_select(".block") do
      assert_select(".input.file") do
        assert_select("input[type=file]")
      end
      assert_select("label", "Avatar")
    end
    
    assert_select('.block.avatar', false, 'Class "avatar" should not be added to block')
    
    assert_select(".block") do
      assert_select(".association.select") do
        assert_select("select") do
          assert_select("option", "Designer")
          assert_select("option", "Developer")
        end
      end
      assert_select(".error", "can't be blank")
      assert_select("label", "Group")
    end
    
    assert_select('.block.group', false, 'Class "group" should not be added to block')
    
    assert_select(".block.with_errors", {:count => 6}, 'There should be 7 blocks with "with_errors" class.')
    assert_select('.field_with_errors', false, 'There should be no tags with "field_with_errors" class.')
  end
  
end
