require "test_helper"

class TimezonesTest < ActionDispatch::IntegrationTest
  setup do
    @calendar = calendars(:one)
    @user = users(:one)
    log_in_as(@user)
  end
  test "slots for 08 in Moscow show up as 06 in Berlin" do
    # create a slot
    Time.zone = "Moscow"
    post calendar_slots_url(@calendar), params: { slot: {
      description: "moskslot",
      start_time: Time.now + 5.days }}
    @slot = Slot.last
    assert_equal "moskslot", @slot.description
    Time.zone = "Berlin"
    # Look at the calendar
    get calendar_url(@calendar, locale: :en)
    assert_select "a", text: I18n.l(@slot.start_time.in_time_zone(Time.zone), format: :time).to_s
  end
end
