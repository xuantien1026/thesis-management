# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  trait :as_student do
    after :create do |user|
      user.add_role :student
    end
  end

  trait :as_lecturer do
    after :create do |user|
      user.add_role :lecturer
    end
  end

  trait :as_head_of_department do
    after :create do |user|
      user.add_role :head_of_department
    end
  end

  trait :as_head_of_faculty do
    after :create do |user|
      user.add_role :head_of_faculty
    end
  end
end
