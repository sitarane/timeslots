require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  test "login" do
    visit new_sessions_url

    assert_selector "h1", text: "Sign In"
  end
end
