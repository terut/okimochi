FactoryGirl.define do
  factory :invitation do
    sequence :email do |n|
      "kirito#{n}@example.com"
    end
    sent_at "2017-03-01T15:00:00Z"
  end
end
