# frozen_string_literal: true

class ApplyTopicPolicy < BaseActionPolicy
  condition :topic_still_receives_application,          on_error: 'Đề tài đã đủ số sinh viên đăng kí'
  condition :student_has_not_applied_for_other_topic,   on_error: 'Bạn cần huỷ đề tài đã đăng kí để đăng kí mới'
  condition :student_has_register_class_correctly,      on_error: 'Bạn chưa đăng kí môn học hợp lệ'
  condition :student_has_appropriate_major,             on_error: 'Bạn đăng kí đề tài không đúng chuyên ngành'
  condition :student_has_appropriate_education_program, on_error: 'Bạn đăng kí đề tài không đúng chương trình đào tạo'

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

  def student_has_register_class_correctly
    case student.dkmh
    when 'DCLV'
      topic.is_a? ThesisProposal
    when 'LVTN'
      topic.is_a? Thesis
    else
      false
    end
  end

  def student_has_appropriate_major
    topic.major.accept? student.major
  end

  def student_has_appropriate_education_program
    topic.education_program.to_s == student.education_program
  end

  def topic_application
    return ThesisProposals::Member if topic.is_a?(ThesisProposal)
    return Theses::Member if topic.is_a?(Thesis)
  end
end
