module Theses
  class FinalSubmissionsController < ApplicationController
    before_action :set_thesis

    def create
      @thesis.final_submission.attach(params[:final_submission])
      redirect_to students_my_thesis_path, notice: 'Đã nộp báo cáo thành công'
    end

    private

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end
  end
end
