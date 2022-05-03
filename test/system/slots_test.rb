require "application_system_test_case"

class SlotsTest < ApplicationSystemTestCase
  setup do
    @host = users(:one)
    @guest = users(:two)
    @calendar = calendars(:one)
  end

  test "Create some slots" do
    login(@host)
    visit calendar_url(@calendar, locale: :en)

    # Add one slot
    click_on "Add a slot"
    fill_in "Description", with: 'First slot'
    fill_in "Start time",
      with: Time.zone.now.tomorrow.beginning_of_day + 8.hours
    click_on "Create Slot"

    assert_text "Slot was successfully created"

    # Add second slot
    click_on "Add a slot"
    fill_in "Description", with: 'Second slot'
    fill_in "Start time",
      with: Time.zone.now.tomorrow.beginning_of_day + 14.hours
    click_on "Create Slot"

    assert_text "Slot was successfully created"
    assert_link "08:00"
    assert_link "14:00"
  end

  test 'book a slot' do
    login(@guest)
    visit calendar_url(@calendar, locale: :en)
    click_on "09:00"
    choose "I would like to have this one"
    click_on "Create Booking"

    assert_text "Booking was successfully created."
  end
end
