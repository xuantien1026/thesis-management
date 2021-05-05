# frozen_string_literal: true

FactoryBot.define do
  factory :thesis_proposal do
    title { Faker::Lorem.sentence }
    english_title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    references { 3.times.map { Faker::Lorem.sentence } }
    majors { 3.times.map { Faker::Lorem.word } }
    max_student_count { rand 1..5 }
    semester { Semester.new }
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
