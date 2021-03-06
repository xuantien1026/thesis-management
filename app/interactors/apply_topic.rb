# frozen_string_literal: true

class ApplyTopic
  include Interactor

  delegate :student, :topic, to: :context

  def call
    policy = ApplyTopicPolicy.new(student, topic)
    context.fail!(errors: policy.errors) unless policy.allowed?
    topic.create_member(student)
  end
end
