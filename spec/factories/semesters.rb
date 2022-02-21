# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id            :bigint           not null, primary key
#  academic_year :integer          not null
#  end_date      :date
#  number        :integer          not null
#  start_date    :date             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :semester do
    number { [1, 2, 3].sample }
    start_date { Faker::Date.backward days: 10_000 }
    academic_year { start_date.year }
  end
end
