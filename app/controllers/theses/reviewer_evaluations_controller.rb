# frozen_string_literal: true

module Theses
  class ReviewerEvaluationsController < LecturerController
    before_action :set_member
    before_action :check_permission

    REVIEWER_EVALUATION_TEMPLATE_PATH = 'app/documents/pre_defense/phieu_danh_gia_LVTN_GVPB_CS.docx'

    def show
      generate_reviewer_evaluation_docx
      send_data(File.read(reviewer_evaluation_file_path), filename: "Phieu_danh_gia_LVTN_GVHD_CS_#{@member.name}.docx")
      File.delete(reviewer_evaluation_file_path)
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

    def generate_reviewer_evaluation_docx
      doc = ::Docx::Document.new(REVIEWER_EVALUATION_TEMPLATE_PATH)
      evaluation = @member.reviewer_evaluation
      thesis = @member.thesis
      reviewer = thesis.reviewer
      doc.bookmarks['semester'].insert_text_before(current_semester.number)
      doc.bookmarks['year'].insert_text_before(current_semester.year)
      doc.bookmarks['reviewer'].insert_text_before(reviewer.name)
      doc.bookmarks['member'].insert_text_before(@member.name)
      doc.bookmarks['mssv'].insert_text_before(@member.mssv)
      doc.bookmarks['thesis'].insert_text_before(thesis.to_s)
      doc.bookmarks['total_marking'].insert_text_before(evaluation.total_marking)
      (evaluation.attributes.keys - %w[id theses_member_id created_at updated_at]).each do |key|
        doc.bookmarks[key].insert_text_before(evaluation.send(key))
      end
      doc.save(reviewer_evaluation_file_path)
    end

    def reviewer_evaluation_file_path
      "tmp/reviewer_evaluation_#{@member.id}.docx"
    end
  end
end
