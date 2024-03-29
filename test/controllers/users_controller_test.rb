require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "New user" do
    get new_users_url
    assert_response :success
    assert_select 'form'
    assert_select 'div a', "I already have an account"
  end
  test "Create user" do
    post users_url params: { user: { name: "some name", email: "some@email.net", password: "somepass" } }
    assert_redirected_to root_url(locale: :en)
  end
end
