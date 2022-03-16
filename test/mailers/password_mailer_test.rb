require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase
  test "reset" do
    mail = PasswordMailer.with(user: users(:one)).reset
    assert_equal 'Password reset', mail.subject
    assert_equal [users(:one).email], mail.to
    #assert_equal ["from@example.com"], mail.from
    assert_match users(:one).name, mail.body.encoded
  end

end
