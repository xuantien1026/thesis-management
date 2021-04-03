# frozen_string_literal: true

# == Schema Information
#
# Table name: midterm_evaluations
#
#  id                   :bigint           not null, primary key
#  thesis_membership_id :bigint           not null
#  passed               :boolean          not null
#  note                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
FactoryBot.define do
  factory :midterm_evaluation do
    thesis_membership { nil }
    passed { false }
    note { 'MyString' }
  end
end
