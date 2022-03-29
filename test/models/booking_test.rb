require "test_helper"

class BookingTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @slot = slots(:one)
  end
  test "User can't create slotless booking" do
    booking = @user.bookings.new(score: 0)
    assert_not booking.valid?
  end
  test "User can't create scoreless booking" do
    booking = @user.bookings.new(slot: @slot)
    assert_not booking.valid?
  end
  test "User can create booking" do
    booking = @user.bookings.new(slot: @slot, score: 0)
    assert booking.save
  end
  test "Slot can't create userless booking" do
    booking = @slot.bookings.new(score: 0)
    assert_not booking.valid?
  end
  test "Slot can't create scoreless booking" do
    booking = @slot.bookings.new(user: @user)
    assert_not booking.valid?
  end
  test "Slot can create new booking" do
    booking = @slot.bookings.new(user: @user, score: 0)
    assert booking.save
  end
end
