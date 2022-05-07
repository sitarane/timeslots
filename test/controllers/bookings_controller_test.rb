require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:two)
    @slot = slots(:one)
    @calendar = calendars(:one)
    @booking = bookings(:two)
    log_in_as(@user)
  end
  test '#create: pick a slot' do
    post bookings_url, params: { booking: {
      user_id: @user.id,
      slot_id: @slot.id,
      score: "want"
       }}
      assert_redirected_to calendar_url(@calendar)
  end
  test '#update a slot' do
    patch booking_url(@booking), params: { booking: {
      slot_id: @slot.id,
      score: "want"
       }}
    @booking.reload
    assert_equal "want", @booking.score
    assert_redirected_to calendar_url(@calendar)
  end
end
