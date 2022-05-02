require "test_helper"

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calendar = calendars(:one)
  end

  test "should get index" do
    get calendars_url(locale: :en)
    assert_response :success
  end

  test "should show calendar" do
    get calendar_url(@calendar, locale: :en)
    assert_response :success
    assert_select 'h1'
  end

  test "Should show new form" do
    log_in_as(users(:one))
    get new_calendar_url(locale: :en)
    assert_response :success
  end

  test "Should show edit form" do
    log_in_as(users(:one))
    get edit_calendar_url(@calendar, locale: :en)
    assert_response :success
  end

  test "Should create calendar" do
    log_in_as(users(:one))
    post calendars_url,
    params: { calendar: {
      name: "a calendar",
      description: "bla bla bla description"
    }}
    assert_redirected_to calendar_url(Calendar.last)
  end

  test "Should update calendar" do
    log_in_as(users(:one))
    patch calendar_url(@calendar),
    params: { calendar: {
      name: "new name"
    }}
    assert_redirected_to calendar_url(@calendar)
  end

  test "Should destroy calendar" do
    log_in_as(users(:one))
    assert_difference "Calendar.count", -1 do
      delete calendar_url(@calendar)
    end
    assert_redirected_to calendars_url
  end
end
