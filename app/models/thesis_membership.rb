# frozen_string_literal: true

class ThesisMembership < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :thesis
  has_one :midterm_evaluation

  delegate :name, to: :student
  delegate :mssv, to: :student
end
