# frozen_string_literal: true

FactoryBot.define do
  factory :major do
    name { Faker::Name.name }
    association :faculty
  end
end
