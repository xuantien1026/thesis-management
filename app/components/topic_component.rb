# frozen_string_literal: true

class TopicComponent < ViewComponent::Base
  def initialize(topic:)
    @topic = topic
  end
end
