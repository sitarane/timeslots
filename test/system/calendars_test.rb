require "application_system_test_case"

class CalendarsTest < ApplicationSystemTestCase
  setup do
    @mock_user = Minitest::Mock.new
    @mock_user.expect :user, users(:one)
    #Current.user = users(:one)

    @mock_policy = Minitest::Mock.new
    @mock_policy.expect :new?, true
    #@mock_policy.expect :create?, true
    @calendar = calendars(:one)
  end

  test "visiting the index" do
    visit calendars_url(locale: :en)
    assert_selector "h1", text: "Calendars"
  end

  test "should create calendar" do
    CalendarPolicy.stub :new, @mock_policy do
      visit calendars_url(locale: :en)
      click_on "New calendar" # Dummy. You aren't logged in.
      debugger
      fill_in "Description", with: @calendar.description
      fill_in "Name", with: @calendar.name
      fill_in "Avance Warning", with: @calendar.advance_warning
      click_on "Create Calendar"

      assert_text "Calendar was successfully created"
      click_on "Back"
    end
    @mock_policy.verify
  end

  test "should update Calendar" do
    visit calendar_url(@calendar, locale: :en)
    click_on "Edit this calendar", match: :first

    fill_in "Description", with: @calendar.description
    fill_in "Name", with: @calendar.name
    click_on "Update Calendar"

    assert_text "Calendar was successfully updated"
    click_on "Back"
  end

  test "should destroy Calendar" do
    log_in_as(users(:one))
    visit calendar_url(@calendar, locale: :en)
    click_on "Destroy this calendar", match: :first

    assert_text "Calendar was successfully destroyed"
  end
end
