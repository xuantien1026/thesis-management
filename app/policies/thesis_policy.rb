# frozen_string_literal: true

class ThesisPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.has_role? :admin
      return lecturer_scope if user.is_a?(Lecturer)
      return student_scope if user.is_a?(Student)
    end

    private

    def lecturer_scope
      scope.where(primary_advisor: user)
    end

    def student_scope
      scope.joins(thesis_members: :student).where(users: { id: user.id })
    end
  end
end
