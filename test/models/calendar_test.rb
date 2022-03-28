require "test_helper"

class CalendarTest < ActiveSupport::TestCase
  def setup
    @calendar = calendars(:one)
  end
  test '#user' do
    assert @calendar.user
    assert_not calendars(:two).user
  end
  test "Calendar invalid without a user" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description"
    )
    assert_not calendar.valid?
  end
  test "Valid calendar can be saved" do
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
