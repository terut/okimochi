FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "kirito#{n}"
    end
    sequence :email do |n|
      "kirito#{n}@example.com"
    end
    name "kirito"
    bio "I'm a Beater."
    time_zone "UTC"
    magic_link_token nil
    magic_link_expires_at nil
    magic_link_sent_at nil
  end
end
