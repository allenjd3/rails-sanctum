require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get csrf" do
    get sessions_csrf_url
    assert_response :success
  end
end
