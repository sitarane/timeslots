require "test_helper"

class TimezonesTest < ActionDispatch::IntegrationTest
  setup do
    @calendar = calendars(:one)
    @owner = users(:one)
    @candidate = users(:two)
    @other_candidate = users(:three)
    log_in_as(@owner)
  end

  test "add an editor to a calendar" do
    assert_difference("@calendar.editors.count") do
      patch calendar_url(@calendar),
        params: {
          calendar: {
            new_editors_email_list: @candidate.email}
        }
    end
    assert_redirected_to calendar_url(@calendar)
    assert_equal I18n.t(:calendar_updated), flash[:notice]
  end

  test "add many editors to a calendar" do
    assert_difference("@calendar.editors.count", 2) do
      patch calendar_url(@calendar),
        params: {
          calendar: {
            new_editors_email_list: "#{@candidate.email} #{@other_candidate.email}"
          }
        }
    end
    assert_redirected_to calendar_url(@calendar)
    assert_equal I18n.t(:calendar_updated), flash[:notice]
  end

  test "editors can only be added once" do
    patch calendar_url(@calendar),
      params: {
        calendar: {
          new_editors_email_list: @candidate.email}
      }
    assert_difference("@calendar.editors.count", 0) do
      patch calendar_url(@calendar),
      params: {
        calendar: {
          new_editors_email_list: @candidate.email}
      }
    end
  end

  test "delete editor" do
    patch calendar_url(@calendar),
      params: {
        calendar: {
          new_editors_email_list: @candidate.email}
      }
    assert_difference("@calendar.editors.count", -1) do
      delete calendar_calendar_assignation_url(
        @calendar,
        CalendarAssignation.where(
          calendar: @calendar,
          user: @owner).first
      )
    end
  end
end
