class ApplyTopic
  include Interactor

  def call
    context.fail!(error: "Đề tài đã đủ số sinh viên đăng kí") unless context.topic.available_for_application?
    context.fail!(error: "Bạn cần huỷ đề tài đã đăng kí để đăng kí mới") if already_applied?
    TopicApplication.create!(user: context.student, topic: context.topic)
  end

  private

  def already_applied?
    TopicApplication.where(user: context.student).exists?
  end
end
