# frozen_string_literal: true

# == Schema Information
#
# Table name: midterm_evaluations
#
#  id                   :bigint           not null, primary key
#  thesis_membership_id :bigint           not null
#  passed               :boolean          not null
#  note                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class MidtermEvaluation < ApplicationRecord
  belongs_to :thesis_membership

  delegate :name, to: :thesis_membership, prefix: :student
  delegate :mssv, to: :thesis_membership, prefix: :student
end
