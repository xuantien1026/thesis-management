# frozen_string_literal: true

class TopicApplicationPolicy < ApplicationPolicy
  def create?
    user.has_role?(:student)
  end
end
