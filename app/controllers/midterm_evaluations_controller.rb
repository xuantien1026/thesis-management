# frozen_string_literal: true

class MidtermEvaluationsController < ApplicationController
  # before_action { head :forbidden unless MidtermEvaluationPolicy.new(user: current_user, thesis: @thesis).allowed? }

  def show
    @thesis = policy_scope(Thesis).first
    respond_to do |format|
      format.pdf { render pdf: 'ket_qua_giua_ki', margin:  { top: 20, bottom: 20, left: 20, right: 20 }, show_as_html: params.key?('debug') }
    end
  end

  def new
    @theses = Thesis.by_lecturer(current_user)
  end

  def evaluate_all_students
    evaluation_params.each do |evaluations|
      MidtermEvaluation.create!(evaluations)
    end
    flash.notice = 'Đã cập nhật kết quả giữa kì thành công'
    redirect_to theses_path
  end

  private

  def set_thesis
    @thesis = Thesis.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluations).map { |p| p.permit(:thesis_member_id, :passed, :note) }
  end
end
