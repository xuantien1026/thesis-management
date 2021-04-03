# frozen_string_literal: true

class ThesisPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(thesis_proposal: :topic).where(topics: { primary_advisor_id: user.id }) if user.has_role? :lecturer
    end
  end
end
