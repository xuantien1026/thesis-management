# frozen_string_literal: true

class ThesisPolicy < ApplicationPolicy
  alias thesis record

  def evaluate_as_advisor?
    user == thesis.primary_advisor && thesis_has_members
  end

  def evaluate_as_reviewer?
    user == thesis.reviewer && thesis_has_members
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

  private

  def thesis_has_members
    thesis.members.present?
  end
end
