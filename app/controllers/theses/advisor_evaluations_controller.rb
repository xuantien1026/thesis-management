# frozen_string_literal: true

module Theses
  class AdvisorEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    ADVISOR_EVALUATION_TEMPLATE_PATH = 'app/documents/pre_defense/phieu_danh_gia_LVTN_GVHD_CS.docx'

    def show
      generate_advisor_evaluation_docx
      send_data(File.read(advisor_evaluation_file_path), filename: "Phieu_danh_gia_LVTN_GVHD_CS_#{@member.name}.docx")
      File.delete(advisor_evaluation_file_path)
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

    def generate_advisor_evaluation_docx
      doc = ::Docx::Document.new(ADVISOR_EVALUATION_TEMPLATE_PATH)
      evaluation = @member.advisor_evaluation
      thesis = @member.thesis
      primary_advisor = thesis.primary_advisor
      doc.bookmarks['semester'].insert_text_before(current_semester.number)
      doc.bookmarks['year'].insert_text_before(current_semester.year)
      doc.bookmarks['advisor_name'].insert_text_before(primary_advisor.name)
      doc.bookmarks['member'].insert_text_before(@member.name)
      doc.bookmarks['mssv'].insert_text_before(@member.mssv)
      doc.bookmarks['thesis'].insert_text_before(thesis.to_s)
      doc.bookmarks['total_marking'].insert_text_before(evaluation.total_marking)
      (evaluation.attributes.keys - %w[id theses_member_id created_at updated_at]).each do |key|
        doc.bookmarks[key].insert_text_before(evaluation.send(key))
      end
      doc.save(advisor_evaluation_file_path)
    end

    def advisor_evaluation_file_path
      "tmp/advisor_evaluation_#{@member.id}.docx"
    end
  end
end
