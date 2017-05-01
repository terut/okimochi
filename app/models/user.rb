class User < ApplicationRecord
  include Normalize
  include Kagishi

  has_many :articles

  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9_\-]+\z/ }, length: { in: 3..20 }, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :name, length: { maximum: 20 }
  validates :bio, length: { maximum: 200 }
  validates :time_zone, presence: true, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.name } }

  before_create :default_name

  nullify :name, :bio

  # TODO we should consider table schema if boards will be good
  def self.find_current
    users = User.limit(20)
    users = users.select { |u| !u.current_article.nil? }
    users.sort { |u1, u2| u2.current_article.published_on <=> u1.current_article.published_on }
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

    def default_name
      self.name ||= self.username
    end
end
