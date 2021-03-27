# frozen_string_literal: true

class TopicReferencesComponent < ViewComponent::Base
  def initialize(topic:)
    @topic = topic
    @references = topic.references.blank? ? [""] : topic.references
  end
end
