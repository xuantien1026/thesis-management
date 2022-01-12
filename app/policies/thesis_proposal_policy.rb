# frozen_string_literal: true

class ThesisProposalPolicy < ApplicationPolicy
  alias thesis_proposal record

  def show?
    user.is_a?(Lecturer) || student_viewing_faculty_approved_proposal?
  end

  def create?
    user.is_a?(Lecturer)
  end

  def update?
    user.is_a? Lecturer
  end

  def destroy?
    user.is_a? Lecturer
  end

  def department_approve?
    user.has_role? :head_of_department
  end

  def faculty_approve?
    user.has_role? :head_of_faculty
  end

  def major_committee_approve?
    user.is_a?(Lecturer) && user.has_role?(:privileged_major_committee_member)
  end

  def final_evaluate?
    !ThesisProposal::FinalEvaluationSet.new(user, Current.semester).evaluated?
  end

  private

  def student_viewing_faculty_approved_proposal?
    user.is_a?(Student) && thesis_proposal.faculty_approved?
  end
end
