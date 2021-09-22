# frozen_string_literal: true

module Theses
  class BatchReviewerEvaluationsController < LecturerController
    before_action :set_thesis
    before_action :check_permission

    def new
      @reviewer_evaluation = ReviewerEvaluation.new
    end

    def create
      @thesis.members.each do |member|
        member_params = reviewer_evaluation_params.merge(theses_member_id: member.id)
        @reviewer_evaluation = ReviewerEvaluation.find_or_initialize_by(theses_member_id: member.id)
        @reviewer_evaluation.assign_attributes(member_params)
        render :new, status: :unprocessable_entity and return unless @reviewer_evaluation.save # rubocop:disable Lint/NonLocalExitFromIterator
      end
      flash.notice = 'Đã lưu phiếu đánh giá LVTN cho tất cả SV trong đề tài'
      redirect_to @thesis
    end

    private

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end

    def check_permission
      head :forbidden unless authorize(@thesis, :evaluate_as_reviewer?)
    end

    def reviewer_evaluation_params
      params.require(:theses_reviewer_evaluation).permit!
    end
  end
end
