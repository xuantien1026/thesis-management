# frozen_string_literal: true

module Admin
  class ThesesController < AdminController
    before_action :set_faculty

    def index
      @q = Thesis.by_faculty(@faculty).includes(thesis_advisors: :lecturer).ransack(search_params)
      @theses = @q.result.order(:ordering)
      @lecturers = Lecturer.by_faculty(@faculty)
    end

    def new; end

    def create; end

    private

    def set_faculty
      @faculty = Faculty.find(params[:faculty_id])
    end

    def search_params
      ransack_params.merge(primary_advisors_param)
    end

    def primary_advisors_param
      return {} unless params[:primary_advisor_ids]

      {
        thesis_advisors_lecturer_id_in: params.require(:primary_advisor_ids),
        thesis_advisors_primary_eq: true
      }
    end

    def ransack_params
      return {} unless params[:q]

      params.require(:q).permit(:title_or_english_title_cont)
    end
  end
end
