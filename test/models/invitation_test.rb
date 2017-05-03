require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  test "email should not be blank" do
    invitation = build(:invitation, email: "")
    assert invitation.invalid?
    invitation.email = " "
    assert invitation.invalid?
    invitation.email = nil
    assert invitation.invalid?
  end

  test "email should be unique" do
    email = "abc@example.com"
    create(:invitation, email: email)
    invitation = build(:invitation, email: email)
    assert invitation.invalid?
    assert_raises(ActiveRecord::RecordNotUnique) { invitation.save!(validate: false) }
  end

  test ".create_with_email should be return new record when email is new" do
    email = "abc@example.com"
    assert_changes -> { Invitation.where(email: email).count }, from: 0, to: 1 do
      Invitation.create_with_email(email)
    end
  end

  test ".create_with_email should be return present record when email is same" do
    invitation = create(:invitation, email: "abc@example.com")
    travel_to (invitation.sent_at + 15.minutes) do
      assert_nil Invitation.create_with_email(invitation.email)
    end
    travel_to (invitation.sent_at + 15.minutes + 1) do
      assert_equal invitation.id, Invitation.create_with_email(invitation.email).id
    end
  end

  test "#resendable? should be false when sent_at is within 15 minutes" do
    invitation = create(:invitation)
    travel_to (invitation.sent_at + 15.minutes) do
      assert_not invitation.resendable?
    end
    travel_to (invitation.sent_at + 15.minutes + 1) do
      assert invitation.resendable?
    end
  end
end
