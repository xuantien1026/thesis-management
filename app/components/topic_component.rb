# frozen_string_literal: true

class TopicComponent < ViewComponent::Base
  def initialize(user:, topic:)
    @user = user
    @topic = topic
    @tooltip = "<p class='text-left'><b>Mô tả:</b><br>#{topic.description}</p>" \
               "<p class='text-left'><b>Nhiệm vụ:</b><br>#{topic.mission}</p>"
  end
end
