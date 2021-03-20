# frozen_string_literal: true

class TopicPolicy < ApplicationPolicy
  def create?
    user.has_role? :advisor
  end

  def update?
    user.has_role? :advisor
  end

  def destroy?
    user.has_role? :advisor
  end

  class Scope < Scope
    def resolve
      return scope.faculty_approved if user.has_role? :student
      return scope.where(primary_advisor: user) if user.has_role? :lecturer
      return scope.by_department(Department.find_by(head: user)) if user.has_role? :head_of_department
      return scope.department_approved if user.has_role? :head_of_faculty
      scope.none
    end
  end
end
