require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "New user" do
    get new_users_url
    assert_response :success
  end
  test "Create user" do
    post users_url params: { user: { name: "some name", email: "some@email.net", password: "somepass" } }
    # maybe add check that the user was created?
    assert_redirected_to root_url
  end
end
