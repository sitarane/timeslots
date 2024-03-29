require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'login form' do
    get new_sessions_url
    assert_response :success
    assert_select 'form'
    assert_select 'div a', "I don't have an account"
  end
  test 'log in registered user' do
    post sessions_url params: { email: 'john@email.com', password: 'password' }
    assert_redirected_to root_url(locale: :en)
  end
  test "don't log in non-existing user" do
    post sessions_url params: { email: 'not@exist.com', password: 'whatever'  }
    assert_response :success
  end
  test 'log out' do
    log_in_as(users(:one))
    delete sessions_url
    assert_redirected_to root_url(locale: :en)
    assert_not session[:user_id]
  end
end
