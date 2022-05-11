require "test_helper"

class SlotTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  setup do
    @slot = slots(:one)
  end
  test "Empty slot invalid" do
    slot = calendars(:one).slots.new
    assert_not slot.valid?
  end
  test "No date can't be saved" do
    slot = calendars(:one).slots.new(description: "slot description")
    assert_not slot.valid?
  end
  test "Past date can't be saved" do
    slot = calendars(:one).slots.new(start_time: 3.days.ago)
    assert_not slot.valid?
  end
  test "Valid slot can be saved" do
    slot = calendars(:one).slots.new(start_time: 3.days.since)
    assert slot.save
  end
  test 'Job enqueud correctly' do
    assert_enqueued_with(job: AssignWinnerJob) do
      calendars(:one).slots.new(start_time: 3.days.since).save
    end
  end
  test "destroying slot destroys bookings" do
    assert_difference("Booking.all.count", -2) do
      @slot.destroy
    end
  end
end
