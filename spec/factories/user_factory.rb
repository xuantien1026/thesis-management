# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[primary_advisor head] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    transient do
      department { create :department }
    end
  end

  trait :as_student do
    after :create do |user|
      user.add_role :student
    end
  end

  trait :as_lecturer do
    after :create do |user, evaluator|
      user.add_role :lecturer
      user.update(department: evaluator.department)
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
