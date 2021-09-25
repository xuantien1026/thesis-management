# frozen_string_literal: true

module Students
  class ThesisProposalsController < BaseController
    def index
      @thesis_proposals = ::ThesisProposal.faculty_approved.where(semester: current_semester)
    end

    def show
      @thesis_proposal = authorize(::ThesisProposal.find(params[:id]))
    end

    def registered
      @thesis_proposal = ::ThesisProposal.by_student(current_user)
    end
  end
end
