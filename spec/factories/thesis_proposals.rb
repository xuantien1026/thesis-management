# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals
#
#  id                :bigint           not null, primary key
#  description       :text
#  education_program :string
#  english_title     :string
#  majors            :string           default([]), is an Array
#  max_student_count :integer          default(1), not null
#  mission           :string
#  ordering          :integer
#  references        :string           default([]), is an Array
#  school_year       :integer
#  semester_number   :string
#  status            :integer          default("waiting_for_approval")
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :thesis_proposal do
    title { Faker::Lorem.sentence }
    english_title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    references { 3.times.map { Faker::Lorem.sentence } }
    majors { 3.times.map { Faker::Lorem.word } }
    max_student_count { rand 1..5 }
    semester_number { 1 }
    school_year { 2020 }
    education_program { 'CQ' }

    transient do
      primary_advisor { create :lecturer }
      students { [] }
    end

    after(:create) do |thesis_proposal, options|
      thesis_proposal.thesis_proposal_advisors.create(lecturer: options.primary_advisor, primary: true)
      options.students.each { |student| thesis_proposal.create_member(student) }
    end
  end
end
