# frozen_string_literal: true

class ApproveButtonComponent < ViewComponent::Base
  def initialize(user:, topic:)
    @user = user
    @topic = topic
  end

  def call
    button_to 'Approve', @url, class: "btn btn-outline-#{@button_class}"
  end

  private

  def before_render
    if department_approve?
      @url = department_approve_thesis_proposal_path(@topic)
      @button_class = 'btn btn-outline-info'
    elsif major_committee_approve?
      @url = major_committee_approve_thesis_proposal_path(@topic)
      @button_class = 'btn btn-outline-primary'
    elsif faculty_approve?
      @url = faculty_approve_thesis_proposal_path(@topic)
      @button_class = 'btn btn-outline-success'
    end
  end

  def render?
    department_approve? || major_committee_approve? || faculty_approve?
  end

  def department_approve?
    @user.has_role?(:head_of_department) && @topic.waiting_for_approval?
  end

  def major_committee_approve?
    @topic.department_approved?
  end

  def faculty_approve?
    @user.has_role?(:head_of_faculty) && @topic.major_committee_approved?
  end
end
