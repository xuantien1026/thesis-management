# frozen_string_literal: true

module Theses
  class AdvisorEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    def new
      @advisor_evaluation = @member.build_advisor_evaluation
    end

    def create
      @advisor_evaluation = AdvisorEvaluation.new(advisor_evaluation_params)
      if @advisor_evaluation.save
        flash.notice = 'Đã lưu phiếu đánh giá LVTN'
        redirect_to @member.thesis
      else
        render :new
      end
    end

    def edit
      @advisor_evaluation = @member.advisor_evaluation
    end

    def update
      @advisor_evaluation = @member.advisor_evaluation
      @advisor_evaluation.assign_attributes(advisor_evaluation_params)
      if @advisor_evaluation.save
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

    def advisor_evaluation_params
      params.require(:theses_advisor_evaluation).permit!
    end

    def check_permission
      head :forbidden unless @member.thesis.primary_advisor == current_user
    end
  end
end
