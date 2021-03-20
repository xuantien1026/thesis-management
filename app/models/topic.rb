# frozen_string_literal: true

class Topic < ApplicationRecord
  has_many :thesis_applications, dependent: :destroy
  belongs_to :primary_advisor, class_name: 'User'

  enum status: { default: 0, department_approved: 1, faculty_approved: 2 }

  validates :title, presence: true
  validates :description, presence: true
  validates :primary_advisor, presence: true

  scope :by_department, -> (department) { where(primary_advisor: department.lecturers) }
end
