# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Students::ThesisProposalsController, type: :request do
  include_context :signed_in_as_student

  describe 'GET /students/thesis_proposals' do
    subject { get students_thesis_proposals_path }

    let!(:faculty_approved_proposals) do
      create_list :thesis_proposal, 2, status: :faculty_approved, semester: current_semester
    end
    let!(:department_approved_proposals) do
      create_list :thesis_proposal, 2, status: :department_approved, semester: current_semester
    end
    let!(:major_committee_approved_proposals) do
      create_list :thesis_proposal, 2, status: :major_committee_approved, semester: current_semester
    end
    let!(:waiting_for_approval_proposals) do
      create_list :thesis_proposal, 2, status: :waiting_for_approval, semester: current_semester
    end

    let(:previous_semester) { create :semester, start_date: current_semester.start_date - 1 }
    let!(:proposal_from_another_semester) do
      create :thesis_proposal, status: :faculty_approved, semester: previous_semester
    end

    it 'shows faculty approved proposals' do
      subject

      expect(response.body).to include(*faculty_approved_proposals.map(&:to_s))
    end

    it 'does not show department approved proposals' do
      subject

      expect(response.body).not_to include(*department_approved_proposals.map(&:to_s))
    end

    it 'does not show major committee approved proposals' do
      subject

      expect(response.body).not_to include(*major_committee_approved_proposals.map(&:to_s))
    end

    it 'does not show proposals which are waiting for approval' do
      subject

      expect(response.body).not_to include(*waiting_for_approval_proposals.map(&:to_s))
    end

    it 'does not show proposals from previous semesters' do
      subject

      expect(response.body).not_to include(proposal_from_another_semester.to_s)
    end
  end

  describe 'GET /students/thesis_proposals/:id' do
    subject { get students_thesis_proposal_path(thesis_proposal) }

    context 'when thesis proposal is approved by faculty' do
      let(:thesis_proposal) { create :thesis_proposal, status: :faculty_approved }

      it { is_expected.to eq(200) }
    end

    context 'when thesis proposal is approved by major committee' do
      let(:thesis_proposal) { create :thesis_proposal, status: :major_committee_approved }

      it { is_expected.to eq(403) }
    end

    context 'when thesis proposal is approved by department ' do
      let(:thesis_proposal) { create :thesis_proposal, status: :department_approved }

      it { is_expected.to eq(403) }
    end

    context 'when thesis proposal is waiting for approval' do
      let(:thesis_proposal) { create :thesis_proposal, status: :waiting_for_approval }

      it { is_expected.to eq(403) }
    end
  end

  describe 'GET /students/thesis_proposals/registered' do
    subject { get registered_students_thesis_proposals_path }

    context 'when student has not registered for any thesis proposal' do
      before do
        create :thesis_proposal
      end

      it { is_expected.to eq(200) }
    end

    context 'when student has already registered for a thesis proposal' do
      before do
        create :thesis_proposal, students: [student]
      end

      it { is_expected.to eq(200) }
    end
  end
end
