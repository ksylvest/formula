require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  
  def test_root
    get '/'
  end
  
  def test_contact_form
    get '/contact/new'
  end
  
end
