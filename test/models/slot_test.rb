require "test_helper"

class SlotTest < ActiveSupport::TestCase
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
    assert slot.valid?
    assert slot.save
  end
end
