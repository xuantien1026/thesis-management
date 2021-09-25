# frozen_string_literal: true

module Faculties
  class ThesisProposalsController < BaseController
    def index
      @thesis_proposals = ThesisProposal.by_faculty(current_faculty).where(status: %i[department_approved
                                                                                      major_committee_approved
                                                                                      faculty_approved])
    end
  end
end
