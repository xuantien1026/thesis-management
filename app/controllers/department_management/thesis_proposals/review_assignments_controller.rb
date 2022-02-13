# frozen_string_literal: true

module DepartmentManagement
  module ThesisProposals
    class ReviewAssignmentsController < BaseController
      def show
        @thesis_proposals = ThesisProposal.by_department(current_department)
      end
    end
  end
end
