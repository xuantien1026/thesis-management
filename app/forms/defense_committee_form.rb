# frozen_string_literal: true

class DefenseCommitteeForm
  include ActiveModel::Model

  attr_accessor :chairman_id, :secretary_id, :member_ids, :thesis_ids

  validates :chairman_id, presence: true, numericality: true
  validates :secretary_id, presence: true, numericality: true
  validates :member_ids, presence: true
  validates :thesis_ids, presence: true

  def save
    return false unless valid?

    committee = DefenseCommittee.create!
    committee.defense_committee_members.create!(lecturer: chairman, role: :chairman)
    committee.defense_committee_members.create!(lecturer: secretary, role: :secretary)
    members.each { |member| committee.defense_committee_members.create!(lecturer: member) }
    theses.each { |thesis| committee.defense_committee_theses.create!(thesis: thesis) }
    true
  end

  private

  def chairman
    Lecturer.find(chairman_id)
  end

  def secretary
    Lecturer.find(secretary_id)
  end

  def members
    Lecturer.where(id: member_ids)
  end

  def theses
    Thesis.where(id: thesis_ids)
  end
end
