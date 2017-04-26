require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User" do
    user = build(:user, username: "")
    assert user.invalid?
    user.username = nil
    assert user.invalid?
  end
end
