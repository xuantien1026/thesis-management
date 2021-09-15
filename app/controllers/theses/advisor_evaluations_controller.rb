# frozen_string_literal: true

module Theses
  class AdvisorEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    ADVISOR_EVALUATION_TEMPLATE_PATH = 'app/documents/pre_defense/phieu_danh_gia_LVTN_GVHD_CS.docx'

    def show
      file_path = DocxTemplateGenerator.new(ADVISOR_EVALUATION_TEMPLATE_PATH, bookmarks).generate
      send_data(File.read(file_path), filename: "Phieu_danh_gia_LVTN_GVHD_CS_#{@member.name}.docx")
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

    def advisor_evaluation_params
      params.require(:theses_advisor_evaluation).permit!
    end

    def check_permission
      head :forbidden unless @member.thesis.primary_advisor == current_user
    end

    # TODO: move to model
    def bookmarks
      evaluation = @member.advisor_evaluation
      thesis = @member.thesis
      primary_advisor = thesis.primary_advisor
      keys = (evaluation.attributes.keys - %w[id theses_member_id created_at updated_at])
      values = keys.map { |key| evaluation.send(key) }

      attr_bookmarks = keys.zip(values).to_h

      non_attr_bookmarks = {
        semester: current_semester.number,
        year: current_semester.year,
        advisor_name: primary_advisor.name,
        member: @member.name,
        mssv: @member.mssv,
        thesis: thesis.to_s,
        total_marking: evaluation.total_marking
      }

      non_attr_bookmarks.merge(attr_bookmarks)
    end
  end
end
