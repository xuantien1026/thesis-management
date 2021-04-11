# frozen_string_literal: true

# == Schema Information
#
# Table name: faculties
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :faculty do
    name { Faker::Name.name }
  end
end
