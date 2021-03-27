class ApplyTopic
  include Interactor

  delegate :student, :topic, to: :context

  def call
    policy = ApplyTopicPolicy.new(student, topic)
    context.fail!(errors: policy.errors) unless policy.allowed?
    TopicApplication.create!(user: student, topic: topic)
  end
end
