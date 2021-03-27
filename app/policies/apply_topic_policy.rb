class ApplyTopicPolicy < BaseActionPolicy
  condition :user_is_student,                         on_error: 'You must be a student to apply for a topic'
  condition :topic_still_receives_application,        on_error: 'Đề tài đã đủ số sinh viên đăng kí'
  condition :student_has_not_applied_for_other_topic, on_error: 'Bạn cần huỷ đề tài đã đăng kí để đăng kí mới'

  def initialize(user, topic)
    @user = user
    @topic = topic
  end

  private

  attr_reader :user, :topic

  def user_is_student
    user.has_role? :student
  end

  def topic_still_receives_application
    topic.number_of_students > topic.topic_applications.count
  end

  def student_has_not_applied_for_other_topic
    TopicApplication.where(user: user).empty?
  end
end