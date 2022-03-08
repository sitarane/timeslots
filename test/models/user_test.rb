require "test_helper"

class UserTest < ActiveSupport::TestCase
  user = User.new
  assert_not user.save
end
