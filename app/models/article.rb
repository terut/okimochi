class Article < ApplicationRecord
  # For now, inverse_of doesn't work for has_many.
  # ref: https://github.com/rails/rails/blob/faca40dfd4032bbe2373210255eb7aa1c6527503/activerecord/lib/active_record/associations.rb#L1095
  belongs_to :user

  validates :body, presence: true
  validates :published_on, uniqueness: { scope: :user }

  before_save :set_time

  # month: "2017-03"
  def self.with_month(month, time_zone: Time.zone.name)
    d = month.blank? ? Time.current.in_time_zone(time_zone).to_date
                     : Time.zone.parse("#{month}-01").to_date
    from = d.beginning_of_month
    to = d.end_of_month

    where(published_on: from..to)
  end

  def self.find_today(time_zone: Time.zone.name)
    published_on = Time.current.in_time_zone(time_zone).to_date
    find_by(published_on: published_on)
  end

  private

    def set_time
      current = Time.current

      if new_record?
        time_zone = self.user&.time_zone || Time.zone.name
        self.published_on ||= current.in_time_zone(time_zone).to_date
      end

      self.edited_at = current
    end
end
