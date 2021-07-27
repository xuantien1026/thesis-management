# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentManagement::ThesisProposalsController, type: :request do
  describe 'GET /department_management/thesis_proposals' do
    subject { get dept_thesis_proposals_path }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    let(:lecturer) { create :lecturer, department: current_department }
    let!(:thesis_proposals) { create_list :thesis_proposal, 3, primary_advisor: lecturer }

    let(:lecturer_from_other_department) { create :lecturer }
    let!(:proposal_from_other_department) { create :thesis_proposal, primary_advisor: lecturer_from_other_department }

    it 'shows all thesis proposals of current department' do
      subject

      expect(response.body).to include(*thesis_proposals.map(&:to_s))
    end

    it 'does not show proposals from other department' do
      subject

      expect(response.body).not_to include(proposal_from_other_department.to_s)
    end
  end
end
