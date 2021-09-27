# frozen_string_literal: true

FactoryBot.define do
  factory :major_committee do
    name { Faker::Name.name }
    association :major
  end
end
