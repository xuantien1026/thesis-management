# frozen_string_literal: true

class TopicApplicationsController < ApplicationController
  before_action :set_topic
  before_action { authorize @topic, policy_class: TopicApplicationPolicy }

  def create
    result = ApplyTopic.call(student: current_user, topic: @topic)
    if result.success?
      flash[:notice] = 'Đăng kí thành công'
    else
      flash[:alert] = result.error
    end
    redirect_to topic_path(@topic)
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
