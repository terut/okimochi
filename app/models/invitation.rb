class Invitation < ApplicationRecord
  validates :email, presence: true, email: true

  def self.find_with_valid_token(token)
    invitation = self.find_by_token(token)
    return nil if invitation.blank? || invitation.expired?

    invitation
  end

  def self.create_with_token(email)
    if invitation = self.find_by_email(email)
      return nil unless invitation.resendable?

      invitation.update_attributes(self.build_attributes)
    else
      invitation = self.create(self.build_attributes.reverse_merge({ email: email }))
    end

    # TODO Delete expired invitations
    invitation
  end

  def self.build_attributes
    current = Time.current

    {
      token: self.build_token,
      expires_at: current + 3.days,
      sent_at: current
    }
  end

  def self.build_token
		begin
      token = SecureRandom.hex(20)
    end while self.exists?(token: token)
    token
  end

  def expired?
    self.expires_at < Time.current
  end

  # Don't resend for 15 minutes
  def resendable?
    (self.sent_at + 15.minutes) < Time.current
  end
end
