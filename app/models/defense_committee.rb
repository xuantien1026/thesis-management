# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committees
#
#  id            :bigint           not null, primary key
#  session       :integer          default("inactive")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :bigint
#  semester_id   :bigint
#
# Indexes
#
#  index_defense_committees_on_department_id  (department_id)
#  index_defense_committees_on_semester_id    (semester_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#  fk_rails_...  (semester_id => semesters.id)
#
class DefenseCommittee < ApplicationRecord
  belongs_to :department
  has_many :members, class_name: 'DefenseCommittees::Member', dependent: :destroy
  has_many :lecturers, through: :members
  has_many :theses, dependent: :nullify
  belongs_to :semester

  enum session: { completed: 2, active: 1, inactive: 0 }

  accepts_nested_attributes_for :members
  validates_associated :members

  scope :by_lecturer, ->(lecturer) { joins(:members).where(members: { lecturer_id: lecturer.id }) }

  def chairman
    members.find { |member| member.role == 'chairman' }&.lecturer
  end

  def secretary
    members.find { |member| member.role == 'secretary' }&.lecturer
  end

  def peers
    members.filter { |member| member.role == 'peer' }.map(&:lecturer)
  end
end
