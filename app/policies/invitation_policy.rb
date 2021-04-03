# frozen_string_literal: true

class InvitationPolicy < ApplicationPolicy
  def create?
    user.has_role? :head_of_department
  end
end
