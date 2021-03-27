# frozen_string_literal: true

class TopicApplicationsController < ApplicationController
  before_action :set_topic

  def create
    result = ApplyTopic.call(student: current_user, topic: @topic)
    if result.success?
      flash[:notice] = 'Đăng kí thành công'
    else
      flash[:alert] = result.errors
    end
    redirect_to topic_path(@topic)
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
