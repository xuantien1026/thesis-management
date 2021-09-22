# frozen_string_literal: true

module Theses
  class AdvisorEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    def show
      file_path = DocxTemplateGenerator.new(AdvisorEvaluation::TEMPLATE_PATH,
                                            @member.advisor_evaluation.bookmarks).generate
      send_data(File.read(file_path), filename: "Phieu_danh_gia_LVTN_GVHD_#{@member.name}.docx")
      File.delete(file_path)
    end

    def new
      @advisor_evaluation = @member.build_advisor_evaluation
    end

    def create
      @advisor_evaluation = AdvisorEvaluation.new(advisor_evaluation_params)
      if @advisor_evaluation.save
        flash.notice = 'Đã lưu phiếu đánh giá LVTN'
        redirect_to @member.thesis
      else
        render :new, status: :unprocessable_entity
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
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_member
      @member = Member.find(params[:member_id])
    end

    def check_permission
      head :forbidden unless authorize(@member.thesis, :evaluate_as_advisor?)
    end

    def advisor_evaluation_params
      params.require(:theses_advisor_evaluation).permit!
    end
  end
end
