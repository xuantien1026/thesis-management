# frozen_string_literal: true

class DefenseCommitteeForm
  include ActiveModel::Model

  attr_reader :defense_committees

  def initialize(defense_committees_params)
    self.defense_committees_attributes = defense_committees_params[:defense_committees_attributes]
  end

  def defense_committees_attributes=(attributes)
    @defense_committees = attributes.values.map do |attrs|
      DefenseCommittee.new attrs
    end
  end

  def valid?
    defense_committees.each do |committee|
      next if committee.valid?

      errors.add(:base, committee.errors.full_messages)
      return false
    end

    true
  end

  def save
    return false unless valid?

    defense_committees.map(&:save)
  end
end
