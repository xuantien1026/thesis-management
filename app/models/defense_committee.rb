# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committees
#
#  id            :bigint           not null, primary key
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
  has_many :defense_committee_members, dependent: :destroy
  has_many :lecturers, through: :defense_committee_members
  has_many :theses
  belongs_to :semester

  accepts_nested_attributes_for :defense_committee_members
  validates_associated :defense_committee_members

  def chairman
    defense_committee_members.find_by(role: :chairman)&.lecturer
  end

  def secretary
    defense_committee_members.find_by(role: :secretary)&.lecturer
  end

  def members
    defense_committee_members.where(role: :member).map(&:lecturer)
  end
end
