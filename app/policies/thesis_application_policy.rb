# frozen_string_literal: true

class ThesisApplicationPolicy < ApplicationPolicy
  def create?
    user.has_role?(:student) && !applied_for_same_topic?
  end

  def update?
    user.has_role?(:advisor) && record.pending?
  end

  private

  def applied_for_same_topic?
    ThesisApplication.exists?(user: user, topic: record.topic)
  end
end
