class ThesisApplicationsController < ApplicationController
  before_action :set_topic, except: :update

  def index
    @thesis_applications = @topic.thesis_applications
  end

  def create
    @thesis_application = @topic.thesis_applications.new(user: current_user)
    authorize @thesis_application
    if @thesis_application.save
      flash[:notice] = "Success"
      redirect_to topic_thesis_applications_path(@topic)
    else
      render :new
    end
  end

  def new
    @thesis_application = @topic.thesis_applications.new
    authorize @thesis_application
  end

  def update
    thesis_application = ThesisApplication.find(params[:id])
    authorize thesis_application
    thesis_application.update(status: params[:status])
    flash[:notice] = "Success"
    redirect_back(fallback_location: root_path)
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
