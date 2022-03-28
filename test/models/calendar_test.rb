require "test_helper"

class CalendarTest < ActiveSupport::TestCase
  def setup
    @calendar = calendars(:one)
  end
  test "Calendar can be saved" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description",
      users: [users(:one)]
    )
    assert calendar.save
  end
  test "Can assign several users to calendar" do
    @calendar.users << users(:two)
    assert_equal 2, @calendar.users.count
  end
end
