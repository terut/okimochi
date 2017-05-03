require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user should be create" do
    user = build(:user)
    assert user.valid?
  end

  test "username should be not nil and blank" do
    user = build(:user, username: "")
    assert user.invalid?
    user.username = nil
    assert user.invalid?
  end

  test "username should be from 3 to 20 characters" do
    user = build(:user, username: "ab")
    assert_not user.valid?
    user.username = "abc"
    assert user.valid?
    user.username = "ab" * 10
    assert user.valid?
    user.username = "abc" * 7
    assert_not user.valid?
  end

  test "username should consists of letters, numeric, hyphen and underscore" do
    user = build(:user, username: "abc-d0e_9f")
    assert user.valid?
    user = build(:user, username: "abc%")
    assert_not user.valid?
  end

  test "username should be unique" do
    create(:user, username: "abc")
    user = build(:user, username: "abc")
    assert user.invalid?
  end

  test "email should be unique" do
    create(:user, email: "abc@example.com")
    user = build(:user, email: "abc@example.com")
    assert user.invalid?
  end

  test "email should be a specific format" do
    user = build(:user, email: "a_b-c.d@example.com")
    assert user.valid?
    user.email = "abc@example"
    assert_not user.valid?
    user.email = nil
    assert_not user.valid?
    user.email = ""
    assert_not user.valid?
  end

  test "name should be 20 characters maximum" do
    char20 = "ab" * 10
    char21 = "abc" * 7
    user = build(:user, name: char20)
    assert user.valid?
    user.name = char21
    assert_not user.valid?
  end

  test "name should be same as username when it's new record" do
    user = create(:user, name: nil)
    assert_equal user.username, user.name
    name = "abc"
    user = create(:user, name: name)
    assert_equal name, user.name
  end

  test "name should not be blank and be nullified when it's present record" do
    user = create(:user)
    user.update_attributes(name: "")
    assert_nil user.name
    user.update_attributes(name: " ")
    assert_nil user.name
  end

  test "bio should not be blank and be nullified" do
    user = create(:user, bio: "")
    assert_nil user.bio
    user.update_attributes(bio: " ")
    assert_nil user.bio
  end

  test "bio should be 200 characters maximum" do
    user = build(:user, bio: "ab" * 100)
    assert user.valid?
    user.bio = ("ab" * 100) + "a"
    assert_not user.valid?
  end

  test "time zone should not be blank" do
    user = build(:user, time_zone: nil)
    assert user.invalid?
    user.time_zone = " "
    assert user.invalid?
  end

  test "time zone should be correct name" do
    user = build(:user, time_zone: "abc")
    assert user.invalid?
  end

  test ".find_current should return users ordered by current article's published_on" do
    users = [
      create(:user_with_article, published_on: "2017-03-03"),
      create(:user_with_article, published_on: "2017-03-01")
    ]
    assert_equal users.map {|u| u.id }, User.find_current.map { |u| u.id }
  end
end
