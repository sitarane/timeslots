require "application_system_test_case"

class CalendarsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    login(@user)
  end

  test "Create a calendar" do
    visit calendars_url(locale: :en)
    click_on "New calendar"
    fill_in "Name", with: "My brand new calendar"
    click_on "Create Calendar"

    assert_text "Calendar was successfully created"
  end
end
