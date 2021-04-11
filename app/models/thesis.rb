# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                 :bigint           not null, primary key
#  description        :text
#  education_program  :string
#  english_title      :string
#  max_student_count  :integer          default(1), not null
#  mission            :string
#  ordering           :integer
#  references         :string           default([]), is an Array
#  semester           :string
#  status             :integer          default(0)
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  primary_advisor_id :bigint           not null
#  thesis_proposal_id :bigint
#
# Indexes
#
#  index_theses_on_primary_advisor_id  (primary_advisor_id)
#  index_theses_on_thesis_proposal_id  (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (primary_advisor_id => users.id)
#
class Thesis < ApplicationRecord
  belongs_to :primary_advisor, class_name: 'Lecturer'
  belongs_to :thesis_proposal, optional: true
  has_many :thesis_members, dependent: :destroy
  has_many :midterm_evaluations, through: :thesis_members
  has_many :students, through: :thesis_members

  delegate :description, :program, :mission, to: :thesis_proposal, allow_nil: true
end
