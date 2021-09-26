# frozen_string_literal: true

class ApproveButtonComponent < ViewComponent::Base
  def initialize(thesis_proposal:, target_status:)
    @thesis_proposal = thesis_proposal
    @target_status = target_status
  end

  def call
    button_to 'Approve', @url, class: 'btn btn-outline-primary'
  end

  private

  def before_render
    case @target_status
    when :department_approved
      @url = department_approve_thesis_proposal_path(@thesis_proposal)
    when :major_committee_approved
      @url = major_committee_approve_thesis_proposal_path(@thesis_proposal)
    when :faculty_approved
      @url = faculty_approve_thesis_proposal_path(@thesis_proposal)
    end
  end

  def render?
    case @target_status
    when :department_approved
      @thesis_proposal.waiting_for_approval?
    when :major_committee_approved
      @thesis_proposal.department_approved?
    when :faculty_approved
      @thesis_proposal.major_committee_approved?
    else
      false
    end
  end
end
