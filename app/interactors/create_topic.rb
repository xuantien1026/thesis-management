# frozen_string_literal: true

class CreateTopic
  include Interactor

  delegate :topic_params, :students, to: :context

  def call # rubocop:disable Metrics/AbcSize
    context.topic = Topic.new(topic_params)
    context.fail!(errors: topic.errors.full_messages) unless context.topic.save

    students.each do |student|
      application = ApplyTopic.call(student: student, topic: context.topic)
      context.errors ||= []
      context.errors << "Sinh viên #{student.name} đã đăng kí đề tài khác" if application.failure?
    end
    context.fail! if context.errors.present?
  end
end
