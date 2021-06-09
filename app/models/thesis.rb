# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                 :bigint           not null, primary key
#  description        :text
#  education_program  :string
#  english_title      :string
#  majors             :string           default([]), is an Array
#  max_student_count  :integer          default(1), not null
#  mission            :string
#  ordering           :integer
#  references         :string           default([]), is an Array
#  school_year        :integer
#  semester_number    :string
#  status             :integer          default("waiting_for_approval")
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  thesis_proposal_id :bigint
#
# Indexes
#
#  index_theses_on_thesis_proposal_id  (thesis_proposal_id)
#
class Thesis < ApplicationRecord
  composed_of :semester, mapping: [ %w(semester_number semester_number), %w(school_year school_year) ], allow_nil: true
  composed_of :education_program, converter: proc { |string| EducationProgram.new(string) }

  belongs_to :thesis_proposal, optional: true

  has_many :thesis_members, dependent: :destroy
  has_many :students, through: :thesis_members

  has_many :thesis_advisors, dependent: :destroy
  has_many :lecturers, through: :thesis_advisors

  has_many :midterm_evaluations, through: :thesis_members

  scope :by_lecturer, lambda { |lecturer|
    joins(:thesis_advisors).where(thesis_advisors: { lecturer: lecturer })
  }
  scope :by_department, lambda { |department|
    joins(:lecturers).where(users: { department_id: department.id }, thesis_advisors: { primary: true })
  }
  scope :by_faculty, lambda { |faculty|
    joins(:lecturers).where(users: { department_id: faculty.department_ids }, thesis_advisors: { primary: true })
  }

  enum status: { 'waiting_for_approval' => 0, 'department_approved' => 1, 'faculty_approved' => 2 }

  def primary_advisor
    thesis_advisors.find(&:primary).lecturer
  end

  def create_member(student)
    thesis_members.create(student: student)
  end

  def to_s
    title || english_title
  end
end
