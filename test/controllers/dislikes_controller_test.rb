require 'test_helper'

class DislikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get dislikes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get dislikes_destroy_url
    assert_response :success
  end

end
