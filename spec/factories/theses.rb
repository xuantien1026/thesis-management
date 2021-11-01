# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                   :bigint           not null, primary key
#  assignment_date      :date
#  completion_date      :date
#  description          :text
#  education_program    :string
#  english_title        :string
#  max_student_count    :integer          not null
#  mission              :text
#  ordering             :integer
#  reference            :text
#  status               :integer          default("waiting_for_approval")
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  defense_committee_id :bigint
#  major_id             :bigint           not null
#  semester_id          :bigint           not null
#  thesis_proposal_id   :bigint
#
# Indexes
#
#  index_theses_on_defense_committee_id  (defense_committee_id)
#  index_theses_on_major_id              (major_id)
#  index_theses_on_semester_id           (semester_id)
#  index_theses_on_thesis_proposal_id    (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (defense_committee_id => defense_committees.id)
#  fk_rails_...  (major_id => majors.id)
#  fk_rails_...  (semester_id => semesters.id)
#
FactoryBot.define do
  factory :thesis do
    title { Faker::Lorem.sentence }
    english_title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    references { 3.times.map { Faker::Lorem.sentence } }
    majors { 3.times.map { Faker::Lorem.word } }
    max_student_count { rand 1..5 }
    education_program { 'CQ' }
    assignment_date { Faker::Date.backward days: 100 }
    completion_date { Faker::Date.backward days: 10 }
    sequence :ordering
    association :semester

    transient do
      primary_advisor { create :lecturer }
      students { [] }
    end

    after(:create) do |thesis, options|
      thesis.advisors.create(lecturer: options.primary_advisor, primary: true)
      options.students.each { |student| thesis.members.create(student: student) }
    end

    trait :with_midterm_results do
      after(:create) do |thesis|
        thesis.members.each { |member| create :theses_midterm_evaluation, member: member }
      end
    end
  end
end
