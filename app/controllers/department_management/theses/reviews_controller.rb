# frozen_string_literal: true

module DepartmentManagement
  module Theses
    class ReviewsController < BaseController
      before_action :set_thesis
      before_action :set_lecturers, only: %i[new edit]

      def show; end

      def new
        @review = @thesis.build_review
        @lecturers = Lecturer.where(department: current_department)
      end

      def create
        @review = @thesis.build_review(review_params)
        redirect_to dept_thesis_review_path(@thesis) if @review.save
      end

      def edit
        @review = @thesis.review
        @lecturers = Lecturer.where(department: current_department)
      end

      def update
        redirect_to dept_thesis_review_path(@thesis) if @thesis.review.update(review_params)
      end

      private

      def review_params
        params.require(:theses_review).permit(:lecturer_id)
      end

      def set_thesis
        @thesis = Thesis.find(params[:thesis_id])
      end

      def set_lecturers
        @lecturers = Lecturer.where(department: current_department)
      end
    end
  end
end
