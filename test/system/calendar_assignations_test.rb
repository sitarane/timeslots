require "application_system_test_case"

class CalendarAssignationsTest < ApplicationSystemTestCase
  setup do
    @calendar_assignation = calendar_assignations(:one)
  end

  test "visiting the index" do
    visit calendar_assignations_url
    assert_selector "h1", text: "Calendar assignations"
  end

  test "should create calendar assignation" do
    visit calendar_assignations_url
    click_on "New calendar assignation"

    fill_in "Calendar", with: @calendar_assignation.calendar_id
    fill_in "User", with: @calendar_assignation.user_id
    click_on "Create Calendar assignation"

    assert_text "Calendar assignation was successfully created"
    click_on "Back"
  end

  test "should update Calendar assignation" do
    visit calendar_assignation_url(@calendar_assignation)
    click_on "Edit this calendar assignation", match: :first

    fill_in "Calendar", with: @calendar_assignation.calendar_id
    fill_in "User", with: @calendar_assignation.user_id
    click_on "Update Calendar assignation"

    assert_text "Calendar assignation was successfully updated"
    click_on "Back"
  end

  test "should destroy Calendar assignation" do
    visit calendar_assignation_url(@calendar_assignation)
    click_on "Destroy this calendar assignation", match: :first

    assert_text "Calendar assignation was successfully destroyed"
  end
end
