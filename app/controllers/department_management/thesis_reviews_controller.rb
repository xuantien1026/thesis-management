module DepartmentManagement
  class ThesisReviewsController < BaseController
    before_action :set_thesis
    before_action :set_lecturers, only: %i[new edit]

    def show; end

    def new
      @thesis_review = @thesis.build_thesis_review
      @lecturers = Lecturer.where(department: current_department)
    end

    def create
      @thesis_review = @thesis.build_thesis_review(review_params)
      if @thesis_review.save
        redirect_to dept_thesis_review_path(@thesis)
      end
    end

    def edit
      @thesis_review = @thesis.review
      @lecturers = Lecturer.where(department: current_department)
    end

    def update
      if @thesis.review.update(review_params)
        redirect_to dept_thesis_review_path(@thesis)
      end
    end

    private

    def review_params
      params.require(:thesis_review).permit(:lecturer_id)
    end

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end

    def set_lecturers
      @lecturers = Lecturer.where(department: current_department)
    end
  end
end