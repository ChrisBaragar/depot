require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  

  test "should get index" do
    get :index
    assert_response :success
    # These use CSS selector notation to find
    # a minimum of 4 
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 5
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "markup needed for store.js.coffee is in place" do
    get :index
    assert_select '.store .entry > img', 5
    assert_select '.entry input[type=submit]', 5
  end

end
