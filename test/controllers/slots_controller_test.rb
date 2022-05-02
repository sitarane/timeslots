require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @slot = slots(:one)
    @calendar = calendars(:one)
  end
  # test 'must log in to see slots' do
  #   get slot_url(@slot, locale: :en)
  #   assert_error
  # end
  test '#show a slot' do
    log_in_as(@user)
    get calendar_slot_url(@calendar, @slot, locale: :en)
    assert_response :success
  end
  test '#new slot page' do
    log_in_as(@user)
    get new_calendar_slot_url(@calendar, locale: :en)
    assert_response :success
  end
  test '#edit slot page' do
    log_in_as(@user)
    get edit_calendar_slot_url(@calendar, @slot, locale: :en)
    assert_response :success
  end
  test '#create new slot' do
    log_in_as(@user)
    post calendar_slots_url(@calendar), params: { slot: {
      description: "some desc",
      start_time: Time.zone.now + 5.days }}
    assert_redirected_to calendar_url(@calendar)
  end
  test '#update existing slot' do
    log_in_as(@user)
    patch calendar_slot_url(@calendar, @slot), params:
      { slot: { description: "new desc" }}
    assert_redirected_to calendar_url(@calendar)
  end
  test '#destroy existing slot' do
    log_in_as(@user)
    assert_difference "Slot.count", -1 do
      delete calendar_slot_url(@calendar, @slot)
    end
    assert_redirected_to calendar_url(@calendar)
  end
end
