# frozen_string_literal: true

module DepartmentManagement
  module ThesisProposals
    class ReviewsController < BaseController
      before_action :set_thesis_proposal
      before_action :set_lecturers, only: %i[new edit]

      def show; end

      def new
        @review = @thesis_proposal.build_review
        @lecturers = Lecturer.where(department: current_department)
      end

      def create
        @review = @thesis_proposal.build_review(review_params)
        redirect_to dept_thesis_proposal_review_path(@thesis_proposal) if @review.save
      end

      def edit
        @review = @thesis_proposal.review
        @lecturers = Lecturer.where(department: current_department)
      end

      def update
        redirect_to dept_thesis_proposal_review_path(@thesis_proposal) if @thesis_proposal.review.update(review_params)
      end

      private

      def review_params
        params.require(:thesis_proposals_review).permit(:lecturer_id)
      end

      def set_thesis_proposal
        @thesis_proposal = ThesisProposal.find(params[:thesis_proposal_id])
      end

      def set_lecturers
        @lecturers = Lecturer.where(department: current_department)
      end
    end
  end
end
