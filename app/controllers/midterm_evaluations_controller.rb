# frozen_string_literal: true

class MidtermEvaluationsController < ApplicationController
  before_action { head :forbidden unless current_user.is_a? Lecturer }
  before_action :set_thesis, only: %i[edit update]

  def show
    theses = Thesis.by_lecturer(current_user)
    @thesis_members = ThesisMember.where(thesis_id: theses.ids)
    respond_to do |format|
      format.pdf do
        render pdf: 'ket_qua_giua_ki', margin: { top: 20, bottom: 20, left: 20, right: 20 },
               show_as_html: params.key?('debug')
      end
    end
  end

  def new
    @theses = Thesis.by_lecturer(current_user)
  end

  def create
    params[:evaluations].each do |member_id, evaluations|
      MidtermEvaluation.create!(evaluations.permit(:passed, :note).merge(thesis_member_id: member_id))
    end
    flash.notice = 'Đã cập nhật kết quả giữa kì thành công'
    redirect_to theses_path
  end

  def edit; end

  def update
    authorize @thesis, :update_midterm_evaluations?
    params[:evaluations].each do |member_id, evaluations|
      member = @thesis.thesis_members.find(member_id)
      member.midterm_evaluation.update(evaluations.permit(:passed, :note))
    end
    redirect_to @thesis
  end

  private

  def set_thesis
    @thesis = Thesis.find(params[:thesis_id])
  end
end
