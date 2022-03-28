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
  end
end
