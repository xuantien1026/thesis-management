# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThesisProposalsController, type: :request do
  describe 'GET /thesis_proposals' do
    subject { get thesis_proposals_path }

    context 'when user is a lecturer' do
      include_context :signed_in_as_lecturer

      let!(:thesis_proposal) { create :thesis_proposal, primary_advisor: signed_lecturer }
      let!(:thesis_proposal_of_another_lecturer) { create :thesis_proposal }

      it 'shows all thesis proposals of which current lecturer is the primary advisor' do
        subject

        expect(response.body).to include(thesis_proposal.to_s)
      end

      it 'does not show thesis proposal of other lecturers' do
        subject

        expect(response.body).not_to include(thesis_proposal_of_another_lecturer.to_s)
      end
    end

    context 'when user is a student' do
      include_context :signed_in_as_student

      it { is_expected.to eq(403) }
    end
  end

  describe 'GET /thesis_proposals/new' do
    subject { get new_thesis_proposal_path }

    include_context :signed_in_as_lecturer

    it { is_expected.to eq(200) }
  end

  describe 'POST /thesis_proposals' do
    subject { post thesis_proposals_path, params: params }

    include_context :signed_in_as_lecturer

    context 'when validation passes' do
      let(:params) do
        { thesis_proposal: attributes_for(:thesis_proposal).merge(semester_id: current_semester.id, major_id: current_faculty.majors.first.id),
          primary_advisor_id: signed_lecturer.id }
      end

      it { is_expected.to eq(302) }

      it 'creates new thesis proposal' do
        expect { subject }.to change(ThesisProposal, :count).by(1)
      end
    end
  end

  describe 'POST /thesis_proposal/:id/major_committee_approve' do
    subject { post major_committee_approve_thesis_proposal_path(thesis_proposal) }

    let(:thesis_proposal) { create :thesis_proposal }

    context 'when current user is a student' do
      include_context :signed_in_as_student

      it { is_expected.to eq(403) }
    end

    context 'when current lecturer does not have major committee privilege' do
      include_context :signed_in_as_lecturer

      it { is_expected.to eq(403) }
    end

    context 'when current lecturer have major committee privilege' do
      include_context :signed_in_as_privileged_major_committee_member

      it { is_expected.to eq(200) }

      it 'update thesis proposal status to major committee approved' do
        subject

        expect(thesis_proposal.reload).to be_major_committee_approved
      end
    end
  end
end
