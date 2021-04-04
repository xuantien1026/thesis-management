# frozen_string_literal: true

class MidtermEvaluationPolicy < BaseActionPolicy
  def initialize(user:, thesis:)
    @user = user
    @thesis = thesis
  end

  condition :user_is_primary_advisor_of_thesis
  condition :thesis_is_not_evaluated
  condition :thesis_has_members

  private

  attr_reader :user, :thesis

  def user_is_primary_advisor_of_thesis
    user.is_a?(Lecturer) && thesis.primary_advisor == user
  end

  def thesis_is_not_evaluated
    thesis.midterm_evaluations.none?
  end

  def thesis_has_members
    thesis.thesis_members.exists?
  end
end
