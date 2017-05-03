class Invitation < ApplicationRecord
  validates :email, presence: true, email: true

  def self.create_with_email(email)
    attrs = { sent_at: Time.current }
    if invitation = self.find_by(email: email)
      return nil unless invitation.resendable?

      invitation.update_attributes(attrs)
    else
      invitation = self.create(attrs.reverse_merge({ email: email }))
    end

    # TODO Delete expired invitations
    invitation
  end

  # Don't resend for 15 minutes
  def resendable?
    (self.sent_at + 15.minutes) < Time.current
  end
end
