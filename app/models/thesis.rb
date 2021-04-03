# frozen_string_literal: true

class Thesis < ApplicationRecord
  belongs_to :thesis_proposal
  has_many :thesis_memberships, dependent: :destroy
  has_many :midterm_evaluations, through: :thesis_memberships

  delegate :title, :description, :primary_advisor, :program, :mission, :students, to: :thesis_proposal
end
