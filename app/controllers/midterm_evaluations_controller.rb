# frozen_string_literal: true

class MidtermEvaluationsController < ApplicationController
  before_action :set_thesis
  before_action { head :forbidden unless MidtermEvaluationPolicy.new(user: current_user, thesis: @thesis).allowed? }

  def new; end

  def evaluate_all_students
    evaluation_params.each do |evaluations|
      MidtermEvaluation.create!(evaluations)
    end
    flash.notice = 'Đã cập nhật kết quả giữa kì thành công'
    redirect_to @thesis
  end

  private

  def set_thesis
    @thesis = Thesis.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluations).map { |p| p.permit(:thesis_member_id, :passed, :note) }
  end
end
