# frozen_string_literal: true

class MidtermEvaluation < ApplicationRecord
  belongs_to :thesis_membership

  delegate :name, to: :thesis_membership, prefix: :student
  delegate :mssv, to: :thesis_membership, prefix: :student
end
