require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot = slots(:one)
  end
  test "should show slot" do
    get calendar_slot_url(
      calendar_id: @slot.calendar.id,
      id: @slot.id,
      locale: :en
    )
    assert_response :success
  end
end
