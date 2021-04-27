# frozen_string_literal: true

class MidtermEvaluationsController < ApplicationController
  before_action { head :forbidden unless current_user.is_a? Lecturer }

  def show
    theses = Thesis.by_lecturer(current_user)
    @thesis_members = ThesisMember.where(thesis_id: theses.ids)
    respond_to do |format|
      format.pdf { render pdf: 'ket_qua_giua_ki', margin:  { top: 20, bottom: 20, left: 20, right: 20 }, show_as_html: params.key?('debug') }
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

  private

  def set_thesis
    @thesis = Thesis.find(params[:id])
  end
end
