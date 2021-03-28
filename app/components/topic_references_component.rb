# frozen_string_literal: true

class TopicReferencesComponent < ViewComponent::Base
  def initialize(topic:)
    @topic = topic
    @references = topic.references.presence || ['']
  end
end
