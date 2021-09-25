# frozen_string_literal: true

module MajorCommittees
  class ThesisProposalsController < BaseController
    before_action :set_major_committee

    def index
      @thesis_proposals = ThesisProposal.where(major_id: @major_committee.major_id)
    end

    private

    def set_major_committee
      @major_committee = MajorCommittee.find(params[:major_committee_id])
    end
  end
end
