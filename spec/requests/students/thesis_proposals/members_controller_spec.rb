# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Students::ThesisProposal::MembersController, type: :request do
  include_context :signed_in_as_student

  describe 'DELETE /students/thesis_proposals/:thesis_proposal_id/members/:id' do
    subject { delete students_thesis_proposal_member_path(thesis_proposal, member) }

    let!(:thesis_proposal) { create :thesis_proposal }
    let!(:member) { create :thesis_proposal_member, thesis_proposal: thesis_proposal }

    it 'removes member from the specified thesis proposal' do
      expect { subject }.to change(thesis_proposal.members, :count).from(1).to(0)
    end
  end
end
