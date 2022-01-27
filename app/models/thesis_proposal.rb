# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals
#
#  id                :bigint           not null, primary key
#  description       :text
#  education_program :string
#  english_title     :string
#  max_student_count :integer          not null
#  mission           :text
#  ordering          :integer
#  reference         :text
#  status            :integer          default("waiting_for_approval")
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  major_id          :bigint           not null
#  semester_id       :bigint           not null
#
# Indexes
#
#  index_thesis_proposals_on_major_id     (major_id)
#  index_thesis_proposals_on_semester_id  (semester_id)
#
# Foreign Keys
#
#  fk_rails_...  (major_id => majors.id)
#  fk_rails_...  (semester_id => semesters.id)
#
class ThesisProposal < ApplicationRecord
  composed_of :education_program, converter: proc { |str|
                                               str.present? ? EducationProgram.new(str) : nil
                                             }, allow_nil: true

  belongs_to :semester
  belongs_to :major

  has_many :advisors, dependent: :destroy, class_name: 'ThesisProposals::Advisor'
  has_many :lecturers, through: :advisors

  has_many :members, dependent: :destroy, class_name: 'ThesisProposals::Member'
  has_many :students, through: :members
  has_many :final_evaluations, through: :members, class_name: 'ThesisProposals::FinalEvaluation'

  has_one :review, class_name: 'ThesisProposals::Review', dependent: :destroy
  has_one :reviewer, through: :review, source: :lecturer

  has_one :reviewer_evaluation, class_name: 'ThesisProposals::ReviewerEvaluation', dependent: :destroy

  validates :title, :english_title, :semester_id, :major_id, :education_program,
            :mission, :description, :max_student_count, presence: true
  validates :max_student_count, numericality: { greater_than_or_equal_to: 1 }

  enum status: { 'waiting_for_approval' => 0,
                 'department_approved' => 1,
                 'faculty_approved' => 2,
                 'major_committee_approved' => 3 }

  scope :by_lecturer, lambda { |lecturer|
                        joins(:advisors).where(advisors: { lecturer: lecturer })
                      }
  scope :by_department, ->(department) { joins(:lecturers).where(users: { department_id: department.id }) }
  scope :by_faculty, ->(faculty) { joins(:lecturers).where(users: { department_id: faculty.department_ids }) }

  delegate :name, to: :primary_advisor, prefix: true
  delegate :department, :faculty, to: :primary_advisor

  def primary_advisor
    advisors.find_by(primary: true).lecturer
  end

  def to_s
    title || english_title
  end

  def assign_ordering
    self.ordering = next_ordering_in_semester
  end

  private

  def next_ordering_in_semester
    last_thesis = ThesisProposal.where(semester: Current.semester).order(:ordering).last

    last_thesis.present? ? last_thesis.ordering + 1 : 1
  end
end
