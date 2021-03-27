# frozen_string_literal: true

class TopicStudentsComponent < ViewComponent::Base
  def initialize(topic:)
    @topic = topic
    @student_options = student_options
  end

  private

  def render?
    params[:action] != 'edit'
  end

  def students_with_no_topic
    User.with_role(:student).where.not(id: TopicApplication.pluck(:user_id))
  end

  def student_options
    students_with_no_topic.map { |s| ["#{s.mssv} - #{s.name}", s.id] }
  end
end
