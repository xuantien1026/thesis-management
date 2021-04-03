# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id                 :bigint           not null, primary key
#  title              :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :integer          default("newly_created")
#  primary_advisor_id :bigint           not null
#  program            :string           default("CS"), not null
#  number_of_students :integer          default(1), not null
#  mission            :text
#  references         :string           default([]), is an Array
#
class Topic < ApplicationRecord
  PROGRAMS = %w[CS CE CS_CE].freeze

  has_many :topic_applications, dependent: :destroy
  belongs_to :primary_advisor, class_name: 'Lecturer'

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
