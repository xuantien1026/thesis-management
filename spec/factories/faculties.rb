# frozen_string_literal: true

FactoryBot.define do
  factory :faculty do
    name { Faker::Name.name }
  end
end
