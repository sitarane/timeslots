require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test 'log in registered user' do
  #   post sessions_url params: { email: 'john@email.com' }
  #   assert_redirected_to root_url
  # end
  test "don't log in non-existing user" do
    post sessions_url params: { email: 'not@exist.com' }
    assert_response :success
  end
end
