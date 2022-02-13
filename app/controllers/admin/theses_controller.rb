# frozen_string_literal: true

module Admin
  class ThesesController < AdminController
    before_action :set_faculty

    def index
      @q = Thesis.includes(:semester, advisors: :lecturer).ransack(search_params)
      @theses = @q.result.order(:ordering)
      @lecturers = Lecturer.by_faculty(@faculty)
    end

    def new
      @thesis = Thesis.new
      @thesis.advisors.build
    end

    def create
      @thesis = Thesis.new(thesis_params)
      if @thesis.save
        flash.notice = 'Tạo đề cương luận văn thành công'
        redirect_to @thesis
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_faculty
      @faculty = Faculty.find(params[:faculty_id])
    end

    def search_params
      ransack_params.merge(filter_by_current_faculty).merge(filter_by_primary_advisor)
    end

    def ransack_params
      return {} unless params[:q]

      params.require(:q).permit(:title_or_english_title_cont, :semester_id_eq, :education_program_eq,
                                advisors_lecturer_id_in: [])
    end

    def filter_by_current_faculty
      { advisors_lecturer_department_faculty_id_eq: @faculty.id }
    end

    def filter_by_primary_advisor
      { advisors_primary_eq: true }
    end

    def thesis_params
      params.require(:thesis).permit(:semester_id, :major_id, :education_program, :title, :english_title, :description,
                                     :mission, :max_student_count, advisors_attributes: %i[lecturer_id primary])
    end
  end
end
