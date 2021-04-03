# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id                 :bigint           not null, primary key
#  title              :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :integer          default("newly_created")
#  primary_advisor_id :bigint           not null
#  program            :string           default("CS"), not null
#  number_of_students :integer          default(1), not null
#  mission            :text
#  references         :string           default([]), is an Array
#  english_title      :string
#
FactoryBot.define do
  factory :topic do
    transient do
      department { create :department }
    end

    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    references { 3.times.map { Faker::Lorem.sentence } }
    primary_advisor { create :user, :as_lecturer, department: department }
    program { Topic::PROGRAMS.sample }
    number_of_students { rand 1..5 }
  end
end
