require "test_helper"

class CalendarTest < ActiveSupport::TestCase
  def setup
    @calendar = calendars(:one)
  end
  # test '#user' do
  #   assert @calendar.editor
  #   assert_not calendars(:two).editor
  # end
  test "Calendar invalid without an editor" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description"
    )
    assert_not calendar.valid?
  end
  test "Calendar invalid without a name" do
    calendar = Calendar.new(
      description: "bla bla bla description",
      editors: [users(:one)]
    )
    assert_not calendar.valid?
  end
  test "no need to set advance warning" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description",
      editors: [users(:one)]
    )
    assert calendar.save
  end
  test "Valid calendar can be saved" do
    calendar = Calendar.new(
      name: "a calendar",
      description: "bla bla bla description",
      advance_warning: 2,
      editors: [users(:one)]
    )
    assert calendar.save
  end
  test "Can assign several editors to calendar" do
    assert_difference "@calendar.editors.count" do
      @calendar.editors << users(:two)
    end
  end
  test '#bookings' do
    assert_equal 2, @calendar.bookings.count
  end
  test '#guests' do
    assert_equal 2, @calendar.guests.count
  end
  test '#score_board' do
    # is a 4 x 4 hash with values betwen -1 and 1
    test_board = @calendar.score_board
    assert_instance_of Hash, test_board
    assert_equal 2, test_board.length
    assert_equal 2, test_board.first.length
    test_board.each_value do |guest_list|
      guest_list.each_value do |score|
        assert score >= -1
        assert score <= 1
      end
    end
  end
  test "destroying calendar destroys slots" do
    assert_difference("Slot.all.count", -2) do
      @calendar.destroy
    end
  end
end
