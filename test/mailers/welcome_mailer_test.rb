require "test_helper"

class WelcomeMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    mail = WelcomeMailer.with(user: users(:one)).welcome_email
    assert_equal 'Welcome to Timeslots', mail.subject
    assert_equal [users(:one).email], mail.to
    assert_equal ["noreply@timeslo.ts"], mail.from
    assert_match users(:one).name, mail.body.encoded
  end
end
