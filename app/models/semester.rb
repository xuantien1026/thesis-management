# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id            :bigint           not null, primary key
#  academic_year :integer          not null
#  number        :integer          not null
#  start_date    :date             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Semester < ApplicationRecord
  validates :number, inclusion: 1..3

  def to_s
    "Học kì #{number} (#{academic_year}-#{academic_year + 1})"
  end
end
