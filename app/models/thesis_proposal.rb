# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals
#
#  id                :bigint           not null, primary key
#  description       :text
#  education_program :string
#  english_title     :string
#  majors            :string           default([]), is an Array
#  max_student_count :integer          default(1), not null
#  mission           :string
#  ordering          :integer
#  references        :string           default([]), is an Array
#  semester          :string
#  status            :integer          default("waiting_for_approval")
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class ThesisProposal < ApplicationRecord
  composed_of :semester
  composed_of :education_program

  has_many :thesis_proposal_advisors, dependent: :destroy
  has_many :lecturers, through: :thesis_proposal_advisors

  has_many :thesis_proposal_members, dependent: :destroy
  has_many :students, through: :thesis_proposal_members

  validates :title, presence: true

  enum status: { 'waiting_for_approval' => 0, 'department_approved' => 1, 'faculty_approved' => 2 }

  scope :by_lecturer, lambda { |lecturer|
                        joins(:thesis_proposal_advisors).where(thesis_proposal_advisors: { lecturer: lecturer })
                      }
  scope :by_department, ->(department) { joins(:lecturers).where(users: { department_id: department.id }) }

  delegate :name, to: :primary_advisor, prefix: true

  def primary_advisor
    thesis_proposal_advisors.find_by(primary: true).lecturer
  end
end
