require "test_helper"

class CalendarInvitationsTest < ActionDispatch::IntegrationTest
  setup do
    @calendar = calendars(:private)
    @owner = users(:one)
    @guest = users(:two)
    @other_guest = users(:three)
    log_in_as(@owner)
  end

  test 'Add user guest with no account' do
    assert_enqueued_email_with InvitationMailer,
    :created_user, args: {
      user: User.last,
      calendar: @calendar,
      token: Invitation.last.token
      } do
      patch calendar_url(@calendar), params: {
         calendar: {
           new_invites_email_list: 'not_a_user@email.com'
         }
       }
    end
  end
end
