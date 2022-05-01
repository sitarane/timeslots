require "test_helper"

class PasswordsResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test 'Open new password page' do
    get new_password_reset_url
    assert_response :success
  end
  test 'edit'
  test 'Start password reset process' do
    assert_enqueued_email_with PasswordMailer,
    :reset,
    args: { user: @user } do
      post password_reset_url, params: { email: @user.email }
    end
    assert_redirected_to root_url(locale: :en)
  end
  test 'Update password' do
    token = @user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)
    patch password_reset_url,
    params: { token: token,
      user: { password: 'whatevs',
        password_confirmation: 'whatevs' } }
    assert_redirected_to login_path(locale: :en)
  end
end
