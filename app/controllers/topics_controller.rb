# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: %i[show edit update destroy]
  before_action :set_topics, only: %i[department_approve faculty_approve]

  def index
    @topics = policy_scope(Topic)
  end

  def show; end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def edit
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic

    if @topic.save
      redirect_to @topic, notice: 'Tạo đề tài thành công'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @topic
    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Cập nhật đề tài thành công'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @topic
    @topic.destroy
    redirect_to topics_url, notice: 'Xoá đề tài thành công'
  end

  def department_approve
    authorize :topic
    @topics.each(&:department_approved!)
    flash[:notice] = "(#{@topics.count}) Đề tài đã được Bộ Môn duyệt"
    redirect_to topics_path
  end

  def faculty_approve
    authorize :topic
    @topics.each(&:faculty_approved!)
    flash[:notice] = "(#{@topics.count}) Đề tài đã được Khoa duyệt"
    redirect_to topics_path
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def set_topics
    @topics = Topic.where(id: params[:ids])
  end

  def topic_params
    params.require(:topic).permit(
      :title, :description, :primary_advisor_id, :program, :number_of_students, :mission, references: []
    )
  end
end
