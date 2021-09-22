# frozen_string_literal: true

class ThesisPolicy < ApplicationPolicy
  def evaluate_as_advisor?
    record.primary_advisor == user
  end

  def evaluate_as_reviewer?
    record.reviewer == user
  end

  class Scope < Scope
    def resolve
      return lecturer_scope if user.is_a?(Lecturer)
      return student_scope if user.is_a?(Student)
    end

    private

    def lecturer_scope
      scope.by_lecturer(user)
    end

    def student_scope
      scope.faculty_approved
    end
  end
end
