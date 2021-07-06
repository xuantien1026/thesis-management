# frozen_string_literal: true

class DefenseCommitteePolicy < ApplicationPolicy
  def start_session?
    record.inactive? && lecturer_has_session_authority?
  end

  def end_session?
    record.active? && lecturer_has_session_authority?
  end

  class Scope < Scope
    def resolve
      scope.by_lecturer(user)
    end
  end

  private

  def lecturer_has_session_authority?
    %w[chairman secretary].include?(record.members.find_by(lecturer: user).role)
  end
end
