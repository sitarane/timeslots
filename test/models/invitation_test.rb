require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  setup do
    @calendar = calendars(:one)
    @user = users(:one)
    @invitation = invitations(:one)
  end
  test "No user, can't be saved" do
    invitation = @calendar.invitations.new
    assert_not invitation.valid?
  end
  test "When valid, can be saved" do
    invitation = @calendar.invitations.new(user: @user)
    assert invitation.save
  end
  # test "destroying invitation destroys bookings" do
  #   assert_difference("Booking.all.count", -2) do
  #     @invitation.destroy
  #   end
  # end
end
