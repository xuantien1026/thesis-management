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

  def student_options
    Student.without_proposal.map { |s| ["#{s.mssv} - #{s.name}", s.id] }
  end
end
