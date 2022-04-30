require "test_helper"

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mock_policy = Minitest::Mock.new
    @mock_policy.expect :new?, true
    @mock_policy.expect :create?, true
    @mock_policy.expect :edit?, true
    @mock_policy.expect :destroy?, true

    @mock_user = Minitest::Mock.new
    @mock_user.expect :user, users(:one)
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

  test "Should destroy calendar" do
    log_in_as(users(:one))
    delete calendar_url(@calendar, locale: :en)
    assert_redirected_to calendars_url
  end

  test "Should create calendar" do
    log_in_as(users(:one))
    post calendars_url(locale: :en),
    params: { calendar: {
      name: "a calendar",
      description: "bla bla bla description"
    }}
    assert_redirected_to calendar_url(Calendar.last)
  end

end
