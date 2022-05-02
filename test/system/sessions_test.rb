require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end
  test "login" do
    login(@user)
    assert_text "Logged in successfully"
  end
  test 'logout' do
    login(@user)
    click_on "Log out"
    assert_text 'Logged Out'
  end
end
