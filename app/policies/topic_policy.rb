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
end