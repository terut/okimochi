class User < ApplicationRecord
  def authenticate_with_magic_link
    valid_magic_link? && self
  end

  private
  def valid_magic_link?
    self.magic_link_expires_at > Time.zone.now
  end
end
