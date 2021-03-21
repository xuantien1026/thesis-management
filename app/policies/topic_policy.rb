# frozen_string_literal: true

class TopicPolicy < ApplicationPolicy
  def create?
    user.has_role? :lecturer
  end

  def update?
    user.has_role? :lecturer
  end

  def destroy?
    user.has_role? :lecturer
  end

  def department_approve?
    user.has_role?(:head_of_department) && topic_belongs_to_same_department && record.newly_created?
  end

  def faculty_approve?
    user.has_role?(:head_of_faculty) && record.department_approved?
  end

  class Scope < Scope
    def resolve
      return scope.faculty_approved if user.has_role? :student
      return scope.where(primary_advisor: user) if user.has_role? :lecturer
      return scope.by_department(Department.find_by(head: user)) if user.has_role? :head_of_department
      return scope.where(status: %i[deparment_approved faculty_approved]) if user.has_role? :head_of_faculty

      scope.none
    end
  end

  private

  def topic_belongs_to_same_department
    record.department == Department.find_by(head_id: user)
  end
end
