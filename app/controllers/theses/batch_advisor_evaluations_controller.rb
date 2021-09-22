# frozen_string_literal: true

module Theses
  class BatchAdvisorEvaluationsController < LecturerController
    before_action :set_thesis
    before_action :check_permission

    def new
      @advisor_evaluation = AdvisorEvaluation.new
    end

    def create
      @thesis.members.each do |member|
        member_params = advisor_evaluation_params.merge(theses_member_id: member.id)
        @advisor_evaluation = AdvisorEvaluation.find_or_initialize_by(theses_member_id: member.id)
        @advisor_evaluation.assign_attributes(member_params)
        render :new, status: :unprocessable_entity and return unless @advisor_evaluation.save # rubocop:disable Lint/NonLocalExitFromIterator
      end
      flash.notice = 'Đã lưu phiếu đánh giá LVTN cho tất cả SV trong đề tài'
      redirect_to @thesis
    end

    private

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end

    def check_permission
      head :forbidden unless authorize(@thesis, :evaluate_as_advisor?)
    end

    def advisor_evaluation_params
      params.require(:theses_advisor_evaluation).permit!
    end
  end
end
