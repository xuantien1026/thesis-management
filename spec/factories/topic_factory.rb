# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    transient do
      department { create :department }
    end

    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    primary_advisor { create :user, :as_lecturer, department: department }
  end
end
