require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test 'Open new password page' do
    log_in_as(users(:one))
    get edit_password_url
    assert_response :success
  end
end
