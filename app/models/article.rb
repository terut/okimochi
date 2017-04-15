class Article < ApplicationRecord
  belongs_to :user

  # date: "2017-03-01"
  def self.with_month(date)
    d = date.blank? ? Date.today : Date.parse(date)
    from = d.beginning_of_month
    to = d.end_of_month

    where(published_on: from..to)
  end
end
