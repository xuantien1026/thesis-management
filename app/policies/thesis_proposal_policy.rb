# frozen_string_literal: true

class ThesisProposalPolicy < ApplicationPolicy
  def create?
    user.is_a?(Lecturer)
  end

  def update?
    user.has_role? :lecturer
  end

  def destroy?
    user.has_role? :lecturer
  end

  def department_approve?
    user.has_role? :head_of_department
  end

  def faculty_approve?
    user.has_role? :head_of_faculty
  end

  class Scope < Scope
    def resolve
      return student_scope if user.has_role? :student
      return head_of_department_scope if user.has_role? :head_of_department
      return head_of_faculty_scope if user.has_role? :head_of_faculty
      return lecturer_scope if user.is_a?(Lecturer)

      scope.none
    end

    private

    def student_scope
      scope.faculty_approved
    end

    def lecturer_scope
      scope.by_lecturer(user)
    end

    def head_of_department_scope
      scope.by_department(user.department)
    end

    def head_of_faculty_scope
      scope.by_faculty(user.faculty)
    end
  end
end
