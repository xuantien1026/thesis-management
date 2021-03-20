FactoryBot.define do
  factory :topic do
    title  { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    primary_advisor factory: [:user, :as_lecturer]
  end
end
