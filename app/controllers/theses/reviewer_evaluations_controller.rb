# frozen_string_literal: true

module Theses
  class ReviewerEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    REVIEWER_EVALUATION_TEMPLATE_PATH = 'app/documents/pre_defense/phieu_danh_gia_LVTN_GVPB_CS.docx'

    def show
      file_path = DocxTemplateGenerator.new(REVIEWER_EVALUATION_TEMPLATE_PATH, @member.reviewer_evaluation.bookmarks).generate
      send_data(File.read(file_path), filename: "Phieu_danh_gia_LVTN_GVHD_CS_#{@member.name}.docx")
      File.delete(file_path)
    end

    def new
      @reviewer_evaluation = @member.build_reviewer_evaluation
    end

    def create
      @reviewer_evaluation = ReviewerEvaluation.new(reviewer_evaluation_params)
      if @reviewer_evaluation.save
        flash.notice = 'Đã lưu phiếu đánh giá LVTN'
        redirect_to @member.thesis
      else
        render :new, status: :unprocessable_entity
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
        render :edit, status: :unprocessable_entity
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

    def reviewer_evaluation_file_path
      "tmp/reviewer_evaluation_#{@member.id}.docx"
    end
  end
end
