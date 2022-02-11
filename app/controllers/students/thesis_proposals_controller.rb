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
      @member = ::ThesisProposals::Member.find_by(student_id: current_user)
      @thesis_proposal = @member&.thesis_proposal
    end
  end
end
