# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                 :bigint           not null, primary key
#  assignment_date    :date
#  completion_date    :date
#  description        :text
#  education_program  :string
#  english_title      :string
#  majors             :string           default([]), is an Array
#  max_student_count  :integer          default(1), not null
#  mission            :string
#  ordering           :integer
#  references         :string           default([]), is an Array
#  status             :integer          default("waiting_for_approval")
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  semester_id        :bigint           not null
#  thesis_proposal_id :bigint
#
# Indexes
#
#  index_theses_on_semester_id         (semester_id)
#  index_theses_on_thesis_proposal_id  (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (semester_id => semesters.id)
#
class Thesis < ApplicationRecord
  composed_of :education_program, converter: proc { |string| EducationProgram.new(string) }

  belongs_to :semester
  belongs_to :thesis_proposal, optional: true

  has_many :members, class_name: 'Theses::Member', dependent: :destroy
  has_many :students, through: :members
  has_many :midterm_evaluations, class_name: 'Theses::MidtermEvaluation', through: :members

  has_many :advisors, class_name: 'Theses::Advisor', dependent: :destroy
  has_many :lecturers, through: :advisors

  has_one :thesis_review, dependent: :destroy
  alias review thesis_review
  has_one :reviewer, through: :thesis_review, source: :lecturer

  scope :by_lecturer, lambda { |lecturer|
    joins(:advisors).where(advisors: { lecturer: lecturer, primary: true })
  }
  scope :by_department, lambda { |department|
    includes(advisors: :lecturer).where(users: { department_id: department.id }, advisors: { primary: true })
  }
  scope :by_faculty, lambda { |faculty|
    joins(:lecturers).where(users: { department_id: faculty.department_ids }, advisors: { primary: true })
  }

  enum status: { 'waiting_for_approval' => 0, 'department_approved' => 1, 'faculty_approved' => 2 }

  delegate :faculty, :department, to: :primary_advisor

  def primary_advisor
    advisors.find(&:primary).lecturer
  end

  def major
    majors.join(' - ')
  end

  def to_s
    title || english_title
  end
end
