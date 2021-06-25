# frozen_string_literal: true

FactoryBot.define do
  factory :thesis_review do
    association :thesis
    association :lecturer
  end
end
