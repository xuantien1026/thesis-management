# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    primary_advisor factory: %i[user as_lecturer]
  end
end
