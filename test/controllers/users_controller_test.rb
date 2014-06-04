require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get post_tweet" do
    get :post_tweet
    assert_response :success
  end

end
