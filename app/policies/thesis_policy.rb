# frozen_string_literal: true

class ThesisPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(primary_advisor: user) if user.is_a?(Lecturer)
    end
  end
end
