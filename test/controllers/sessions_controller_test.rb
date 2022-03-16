require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'login form' do
    get new_sessions_url
    assert_response :success
    assert_select 'form'
  end
  test 'log in registered user' do
    post sessions_url params: { email: 'john@email.com', password: 'password' }
    assert_redirected_to root_url
  end
  test "don't log in non-existing user" do
    post sessions_url params: { email: 'not@exist.com' }
    assert_response :success
  end
end
