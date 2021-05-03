# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def create?
    user.has_any_role? :admin, :head_of_department, :head_of_faculty
  end
end
