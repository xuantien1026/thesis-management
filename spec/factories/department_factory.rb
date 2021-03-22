# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name { Faker::Lorem.sentence }
    head factory: %i[user as_head_of_department]
    program { Department::PROGRAMS.sample }
  end
end
