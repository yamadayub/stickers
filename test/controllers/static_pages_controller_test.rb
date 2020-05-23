require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get readme" do
    get static_pages_readme_url
    assert_response :success
  end

end
