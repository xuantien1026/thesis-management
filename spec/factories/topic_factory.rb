# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    transient do
      department { create :department }
    end

    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    references { 3.times.map { Faker::Lorem.sentence } }
    primary_advisor { create :user, :as_lecturer, department: department }
    program { Topic::PROGRAMS.sample }
    number_of_students { rand 1..5 }
  end
end
