require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    login(@user)
  end
  test "login" do
    assert_link "Log out"
  end
  test 'logout' do
    click_on "Log out"
    assert_text 'Logged Out'
  end
end
