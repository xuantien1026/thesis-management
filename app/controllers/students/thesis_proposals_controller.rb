# frozen_string_literal: true

module Students
  class ThesisProposalsController < BaseController
    def index
      @thesis_proposals = ThesisProposal.faculty_approved.where(semester: current_semester)
    end
  end
end
