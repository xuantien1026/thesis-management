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
      @url = department_approve_topic_path(@topic)
      @button_class = 'btn btn-outline-info'
    elsif faculty_approve?
      @url = faculty_approve_topic_path(@topic)
      @button_class = 'btn btn-outline-success'
    end
  end

  def render?
    department_approve? || faculty_approve?
  end

  def department_approve?
    @user.has_role?(:head_of_department) && @topic.newly_created?
  end

  def faculty_approve?
    @user.has_role?(:head_of_faculty) && @topic.department_approved?
  end
end
