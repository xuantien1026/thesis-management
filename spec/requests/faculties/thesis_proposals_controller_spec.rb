# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Faculties::ThesisProposalsController, type: :request do
  describe 'GET /faculties/thesis_proposals' do
    subject { get faculties_thesis_proposals_path }

    it_behaves_like :faculty_management_authorized

    include_context :signed_in_as_head_of_faculty

    let(:lecturer) { create :lecturer, department: current_department }
    let!(:thesis_proposals) { create_list :thesis_proposal, 3, primary_advisor: lecturer, status: :department_approved }
    let!(:waiting_for_approval_proposal) do
      create :thesis_proposal, primary_advisor: lecturer, status: :waiting_for_approval
    end

    let(:lecturer_from_other_faculty) { create :lecturer }
    let!(:proposal_from_other_faculty) { create :thesis_proposal, primary_advisor: lecturer_from_other_faculty }

    it 'shows all thesis proposals of current faculty which are already approved by department' do
      subject

      expect(response.body).to include(*thesis_proposals.map(&:to_s))
    end

    it 'does not show proposals from other faculty' do
      subject

      expect(response.body).not_to include(proposal_from_other_faculty.to_s)
    end

    it 'does not show proposals which are not yet approved by department' do
      subject

      expect(response.body).not_to include(waiting_for_approval_proposal.to_s)
    end
  end
end
