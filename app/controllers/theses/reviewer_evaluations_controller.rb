# frozen_string_literal: true

module Theses
  class ReviewerEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    def new
      @reviewer_evaluation = @member.build_reviewer_evaluation
    end

    def create
      @reviewer_evaluation = ReviewerEvaluation.new(reviewer_evaluation_params)
      if @reviewer_evaluation.save
        flash.notice = 'Đã lưu phiếu đánh giá LVTN'
        redirect_to @member.thesis
      else
        render :new
      end
    end

    def edit
      @reviewer_evaluation = @member.reviewer_evaluation
    end

    def update
      @reviewer_evaluation = @member.reviewer_evaluation
      @reviewer_evaluation.assign_attributes(reviewer_evaluation_params)
      if @reviewer_evaluation.save
        flash.notice = 'Đã lưu phiếu đánh giá LVTN'
        redirect_to @member.thesis
      else
        render :edit
      end
    end

    private

    def set_member
      @member = Member.find(params[:member_id])
    end

    def reviewer_evaluation_params
      params.require(:theses_reviewer_evaluation).permit!
    end

    def check_permission
      head :forbidden unless @member.thesis.reviewer == current_user
    end
  end
end
