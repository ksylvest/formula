require 'test_helper'

class ContactFormTest < ActionDispatch::IntegrationTest
  
  fixtures :all
  
  test "contact form" do
    
    post_via_redirect contacts_path
    
    assert_response :success
    
    assert_select(".block.details") do
      assert_select(".input.text") do
        assert_select("textarea")
      end
      assert_select("label", "Details")
      assert_select(".hint", "a detailed description")
      assert_select(".error", "can&#x27;t be blank")
    end
    
    assert_select(".block.name") do
      assert_select(".input.string") do
        assert_select("input[type=text]")
      end
      assert_select("label", "Name")
      assert_select(".hint", "first and last name")
      assert_select(".error", "can&#x27;t be blank")
    end
    
    assert_select(".block.email") do
      assert_select(".input.email") do
        assert_select("input[type=email]")
      end
      assert_select("label", "Email")
      assert_select(".hint", "sample@example.com")
      assert_select(".error", "can&#x27;t be blank and is not valid")
    end
        
    assert_select(".block.phone") do
       assert_select(".input.phone") do
         assert_select("input[type=tel]")
       end
       assert_select("label", "Phone")
       assert_select(".hint", "+01 (555) 555-5555")
       assert_select(".error", "can&#x27;t be blank and is not valid")
     end
    
    assert_select(".block.url") do
      assert_select(".input.url") do
        assert_select("input[type=url]")
      end
      assert_select("label", "Website")
      assert_select(".hint", "http://example.com/")
      assert_select(".error", "can&#x27;t be blank")
    end
        
    assert_select(".block.avatar") do
      assert_select(".input.file") do
        assert_select("input[type=file]")
      end
      assert_select("label", "Avatar")
    end
        
    assert_select(".block.group") do
      assert_select(".association.select") do
        assert_select("select") do
          assert_select("option", "Designer")
          assert_select("option", "Developer")
        end
      end
      assert_select(".error", "can&#x27;t be blank")
      assert_select("label", "Group")
    end
    
    assert_select(".block.errors.name", true, 'Name block should have "errors" class')    
    assert_select(".block.errors.details", true, 'Details block should have "errors" class')
    
    assert_select('#contact_secret', true, 'There should be hidden field')
    assert_select('.block > #contact_secret', false, 'The hidden field should not be wrapped with a block')
    
  end
  
end
