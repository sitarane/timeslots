require "test_helper"

class TimezonesTest < ActionDispatch::IntegrationTest
  setup do
    @calendar = calendars(:one)
    @owner = users(:one)
    @candidate = users(:two)
    @other_candidate = users(:three)
    log_in_as(@owner)
  end

  test "add a manager to a calendar" do
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

  test "add many managers to a calendar" do
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
end
