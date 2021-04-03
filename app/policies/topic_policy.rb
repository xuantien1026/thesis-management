# frozen_string_literal: true

class TopicPolicy < ApplicationPolicy
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
      return lecturer_scope if user.is_a?(Lecturer)
      return head_of_department_scope if user.has_role? :head_of_department
      return head_of_faculty_scope if user.has_role? :head_of_faculty

      scope.none
    end

    private

    def student_scope
      scope.faculty_approved
    end

    def lecturer_scope
      scope.where(primary_advisor: user)
    end

    def head_of_department_scope
      scope.by_department(Department.find_by(head: user))
    end

    def head_of_faculty_scope
      scope.where(status: %i[department_approved faculty_approved])
    end
  end

  private

  def topic_belongs_to_same_department
    record.department == Department.find_by(head_id: user)
  end
end
