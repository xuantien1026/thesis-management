class ThesisApplicationPolicy < ApplicationPolicy
  def create?
    user.has_role?(:student) && !applied_for_same_topic?
  end

  def update?
    user.has_role?(:advisor) && record.pending?
  end

  private

  def applied_for_same_topic?
    ThesisApplication.where(user: user, topic: record.topic).exists?
  end
end