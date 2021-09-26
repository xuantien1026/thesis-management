# frozen_string_literal: true

module DepartmentManagement
  class ThesisProposalsController < BaseController
    def index
      @thesis_proposals = ThesisProposal.by_department(current_department).includes(:major)
    end
  end
end
