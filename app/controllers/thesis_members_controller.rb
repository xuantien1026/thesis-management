# frozen_string_literal: true

class ThesisMembersController < ApplicationController
  before_action :set_thesis

  def create
    result = ApplyTopic.call(student: current_user, topic: @thesis)
    if result.success?
      flash[:notice] = 'Đăng kí thành công'
    else
      flash[:alert] = result.errors
    end
    redirect_to @thesis
  end

  private

  def set_thesis
    @thesis = Thesis.find(params[:thesis_id])
  end
end
