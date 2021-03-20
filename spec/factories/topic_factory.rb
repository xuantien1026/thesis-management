FactoryBot.define do
  factory :topic do
    title  { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
