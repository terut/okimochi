class Article < ApplicationRecord
  include Normalize

  belongs_to :user

  nullify :body

  # month: "2017-03"
  def self.with_month(month, time_zone: Time.zone.name)
    d = month.blank? ? Time.current.in_time_zone(time_zone).to_date
                     : Time.zone.parse("#{month}-01").to_date
    from = d.beginning_of_month
    to = d.end_of_month

    where(published_on: from..to)
  end
end
