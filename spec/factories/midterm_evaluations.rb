# frozen_string_literal: true

FactoryBot.define do
  factory :midterm_evaluation do
    thesis_membership { nil }
    passed { false }
    note { 'MyString' }
  end
end
