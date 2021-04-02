# frozen_string_literal: true

class Topic < ApplicationRecord
  PROGRAMS = %w[CS CE CS_CE].freeze

  has_many :topic_applications, dependent: :destroy
  belongs_to :primary_advisor, class_name: 'User'

  enum status: { newly_created: 0, department_approved: 1, faculty_approved: 2 }

  validates :title, presence: true
  validates :description, presence: true
  validates :primary_advisor, presence: true
  validates :program, inclusion: PROGRAMS
  validates :number_of_students, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :by_department, ->(department) { where(primary_advisor: department.lecturers) }

  delegate :department, to: :primary_advisor
  delegate :name, to: :primary_advisor, prefix: true

  def available_for_application?
    number_of_students > topic_applications.count
  end

  def students
    User.where(id: topic_applications.pluck(:user_id))
  end
end
