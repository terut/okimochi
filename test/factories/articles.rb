FactoryGirl.define do
  factory :article do
    user
    body "I'm a Beater."
    published_on "2017-03-02T18:00:00"
    edited_at "2017-03-02T19:00:00"
  end
end
