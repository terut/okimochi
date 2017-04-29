class User < ApplicationRecord
  has_many :articles

  #validates :username, presence: true, format: { with: /\A[a-zA-Z0-9_\-]+\z/ }, length: { in: 3..20 }, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  #validates :name, presence: true, length: { in: 3..20 }, allow_nil: true
  #validates :bio, presence: true, length: { maximum: 200 }, allow_nil: true
  #validates :time_zone, presence: true, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.name } }

  before_create :default_name

  # TODO we should consider table schema if boards will be good
  def self.find_current
    users = User.limit(20)
    users = users.select { |u| !u.current_article.nil? }
    users.sort { |u1, u2| u2.current_article.published_on <=> u1.current_article.published_on }
  end

  def authenticate_with_magic_link
    !magic_link_expired? && self
  end

  def update_magic_link
    self.update_attributes(self.class.build_attributes)
  end

  # Don't resend for 15 minutes
  def magic_link_resendable?
    self.magic_link_sent_at.blank? || (self.magic_link_sent_at + 15.minutes) < Time.current
  end

  def avatar
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}.jpg?s=200"
  end

  # TODO N+1 query
  def current_article
    @current_article ||= self.articles.order(:published_on).last
  end

  private

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

    def default_name
      self.name ||= self.username
    end
end
