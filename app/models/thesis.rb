# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                 :bigint           not null, primary key
#  thesis_proposal_id :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Thesis < ApplicationRecord
  belongs_to :thesis_proposal
  has_many :thesis_memberships, dependent: :destroy
  has_many :midterm_evaluations, through: :thesis_memberships

  delegate :title, :description, :primary_advisor, :program, :mission, :students, to: :thesis_proposal
end