# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_memberships
#
#  id         :bigint           not null, primary key
#  thesis_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#
class ThesisMembership < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :thesis
  has_one :midterm_evaluation

  delegate :name, to: :student
  delegate :mssv, to: :student
end
