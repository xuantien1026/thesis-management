# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                 :bigint           not null, primary key
#  thesis_proposal_id :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ordering           :integer
#  title              :string
#  english_title      :string
#
class Thesis < ApplicationRecord
  belongs_to :primary_advisor, class_name: 'Lecturer'
  belongs_to :thesis_proposal, optional: true
  has_many :thesis_memberships, dependent: :destroy
  has_many :midterm_evaluations, through: :thesis_memberships

  delegate :description, :program, :mission, :students, to: :thesis_proposal, allow_nil: true
end
