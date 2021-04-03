# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  program    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :department do
    name { Faker::Lorem.sentence }
    head factory: %i[user as_head_of_department]
    program { Department::PROGRAMS.sample }
  end
end
