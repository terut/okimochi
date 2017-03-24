class User < ApplicationRecord
  has_many :articles

  validates :email, presence: true, email: true

  def authenticate_with_magic_link
    !magic_link_expired? && self
  end

  def update_magic_link
    self.update_attributes(self.class.build_attributes)
  end

  def self.build_attributes
    current = Time.current

    {
      magic_link_token: self.build_token,
      magic_link_expires_at: current + 15.minutes,
      magic_link_sent_at: current
    }
  end

  def self.build_token
		begin
      token = SecureRandom.hex(20)
    end while self.exists?(magic_link_token: token)
    token
  end

  def magic_link_expired?
    self.magic_link_expires_at < Time.current
  end

  # Don't resend for 15 minutes
  def magic_link_resendable?
    self.magic_link_sent_at.blank? || (self.magic_link_sent_at + 15.minutes) < Time.current
  end
end
