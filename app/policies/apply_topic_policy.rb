# frozen_string_literal: true

class ApplyTopicPolicy < BaseActionPolicy
  condition :topic_still_receives_application,        on_error: 'Đề tài đã đủ số sinh viên đăng kí'
  condition :student_has_not_applied_for_other_topic, on_error: 'Bạn cần huỷ đề tài đã đăng kí để đăng kí mới'

  def initialize(student, topic)
    @student = student
    @topic = topic
  end

  private

  attr_reader :student, :topic

  def topic_still_receives_application
    topic.max_student_count > topic.students.count
  end

  def student_has_not_applied_for_other_topic
    topic_application.where(student: student).empty?
  end

  def topic_application
    return ThesisProposalMember if topic.is_a?(ThesisProposal)
  end
end
