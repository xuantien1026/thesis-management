# frozen_string_literal: true

class ThesisProposalPolicy < ApplicationPolicy
  def create?
    user.is_a?(Lecturer)
  end

  def update?
    user.is_a? Lecturer
  end

  def destroy?
    user.is_a? Lecturer
  end

  def department_approve?
    user.has_role? :head_of_department
  end

  def faculty_approve?
    user.has_role? :head_of_faculty
  end
end
