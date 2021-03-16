class ThesisApplicationsController < ApplicationController
  before_action :set_topic

  def index
    @thesis_appications = @topic.thesis_applications
  end

  def create
    @topic.thesis_applications.create(user: current_user)
    flash[:notice] = "Success"
    redirect_to thesis_applications_path(@topic)
  end

  def new
    @thesis_application = @topic.thesis_applications.new
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
