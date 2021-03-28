# frozen_string_literal: true

FactoryBot.define do
  factory :topic_application do
    user
    topic
  end
end
