# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: %i[show edit update destroy department_approve faculty_approve]

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

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    authorize @topic
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    authorize @topic
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def department_approve
    authorize @topic
    @topic.department_approved!
    flash[:notice] = 'Topic is approved!'
    redirect_to topics_path
  end

  def faculty_approve
    authorize @topic
    @topic.faculty_approved!
    flash[:notice] = 'Topic is approved!'
    redirect_to topics_path
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
