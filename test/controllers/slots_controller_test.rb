require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot = slots(:one)
  end

  test "should get index" do
    get slots_url(locale: :en)
    assert_response :success
    assert_select 'table'
  end

  # test "should get new" do
  #   # needs logged in
  #   get new_slot_url
  #   assert_response :success
  # end

  # test "should create slot" do
  #   # needs logged in
  # end

  test "should show slot" do
    get slot_url(@slot, locale: :en)
    assert_response :success
  end

  # test "should get edit" do
      # needs logged in
  #   get edit_slot_url(@slot)
  #   assert_response :success
  # end

  # test "should update slot" do
  #   # needs logged in
  #   patch slot_url(@slot), params: { slot: { description: @slot.description, name: @slot.name, start_time: @slot.start_time, user_id: @slot.user_id } }
  #   assert_redirected_to slot_url(@slot)
  # end
  #
  # test "should destroy slot" do
  #   # needs logged in
  #   assert_difference("Slot.count", -1) do
  #     delete slot_url(@slot)
  #   end
  #
  #   assert_redirected_to slots_url
  # end
end
