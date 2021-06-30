# frozen_string_literal: true

module Theses
  class MidtermEvaluationSetPolicy < ApplicationPolicy
    def show?
      user.is_a?(Lecturer)
    end

    def create?
      user.is_a?(Lecturer) && !record.evaluated?
    end

    def update?
      user.is_a?(Lecturer) && user.has_role?(:privileged_lecturer)
    end
  end
end
