require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Empty user invalid" do
    user = User.new(calendars: [calendars(:one)])
    assert_not user.valid?
  end
  test "Valid user can be saved" do
    user = User.new(name: "John *d<ä&", email: "john@whatevs.com", password: "superman69")
    assert user.valid?
    assert user.save
  end
  test "No password can't be saved" do
    user = User.new(name: "John *d<ä&", email: "john@whatevs.com")
    assert_not user.valid?
  end
  test "No name can't be saved" do
    user = User.new(email: "john@whatevs.com", password: "superman69")
    assert_not user.valid?
  end
  test "typo in email" do
    user = User.new(name: "John *d<ä&", email: "john:whatevs.com", password: "superman69")
    assert_not user.valid?
  end
  test "Email already taken" do
    user = User.new(name: "John *d<ä&", email: "john@email.com", password: "superman69")
    assert_not user.valid?
  end
  test "Name already taken" do
    user = User.new(name: "Jean", email: "john@whatevs.com", password: "superman69")
    assert_not user.valid?
  end
end
