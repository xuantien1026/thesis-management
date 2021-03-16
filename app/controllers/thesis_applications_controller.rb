class ThesisApplicationsController < ApplicationController
  before_action :set_topic, except: :update

  def index
    @thesis_appications = @topic.thesis_applications
  end

  def create
    @topic.thesis_applications.create(user: current_user)
    flash[:notice] = "Success"
    redirect_to topic_thesis_applications_path(@topic)
  end

  def new
    @thesis_application = @topic.thesis_applications.new
  end

  def update
    thesis_application = ThesisApplication.find(params[:id])
    thesis_application.update(status: params[:status])
    flash[:notice] = "Success"
    redirect_back(fallback_location: root_path)
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
