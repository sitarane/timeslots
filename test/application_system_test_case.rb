require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: {
    browser: :remote,
    url: "http://chrome-server:4444"
  }

  def login(user, password = "password")
    visit new_sessions_url
    assert_selector "h1", text: "Sign In"
    fill_in "email", with: user.email
    fill_in "password", with: password
    click_on "login"
  end
end
