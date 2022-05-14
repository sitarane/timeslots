require "test_helper"

class CalendarAssignationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calendar_assignation = calendar_assignations(:one)
  end

  test "should get index" do
    get calendar_assignations_url
    assert_response :success
  end

  test "should get new" do
    get new_calendar_assignation_url
    assert_response :success
  end

  test "should create calendar_assignation" do
    assert_difference("CalendarAssignation.count") do
      post calendar_assignations_url, params: { calendar_assignation: { calendar_id: @calendar_assignation.calendar_id, user_id: @calendar_assignation.user_id } }
    end

    assert_redirected_to calendar_assignation_url(CalendarAssignation.last)
  end

  test "should show calendar_assignation" do
    get calendar_assignation_url(@calendar_assignation)
    assert_response :success
  end

  test "should get edit" do
    get edit_calendar_assignation_url(@calendar_assignation)
    assert_response :success
  end

  test "should update calendar_assignation" do
    patch calendar_assignation_url(@calendar_assignation), params: { calendar_assignation: { calendar_id: @calendar_assignation.calendar_id, user_id: @calendar_assignation.user_id } }
    assert_redirected_to calendar_assignation_url(@calendar_assignation)
  end

  test "should destroy calendar_assignation" do
    assert_difference("CalendarAssignation.count", -1) do
      delete calendar_assignation_url(@calendar_assignation)
    end

    assert_redirected_to calendar_assignations_url
  end
end
