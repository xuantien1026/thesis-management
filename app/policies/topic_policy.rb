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
      scope.faculty_approved if user.has_role? :student
    end
  end
end