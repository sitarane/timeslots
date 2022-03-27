require "test_helper"

class CalendarTest < ActiveSupport::TestCase
  def setup
    @calendar = calendars(:one)
  end
  test "Calendar can be saved" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description"
    )
    assert calendar.valid?
    assert calendar.save
  end
  test "Can assign user to calendar" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description",
      users: [users(:one)]
    )
    assert_equal users(:one).name, calendar.users.first.name
  end
  test "Can assign several users to calendar" do
    @calendar.users << users(:one)
    @calendar.users << users(:two)
    assert_equal 2, @calendar.users.count
  end
end
