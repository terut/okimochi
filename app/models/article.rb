class Article < ApplicationRecord
  belongs_to :user

  # month: "2017-03"
  def self.with_month(month)
    d = month.blank? ? Date.current : Time.zone.parse("#{month}-01").to_date
    from = d.beginning_of_month
    to = d.end_of_month

    where(published_on: from..to)
  end
end
