# frozen_string_literal: true

# == Schema Information
#
# Table name: semester_times
#
#  id              :bigint           not null, primary key
#  school_year     :integer
#  semester_number :integer
#  start_date      :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :semester_time do
    semester_number { 1 }
    school_year { 1 }
    start_date { '2021-06-04' }
  end
end
