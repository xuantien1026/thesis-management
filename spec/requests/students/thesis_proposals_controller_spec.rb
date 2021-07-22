# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Students::ThesisProposalsController, type: :request do
  describe 'GET /students/thesis_proposals' do
    context 'when user is a lecturer' do
      include_context :signed_in_as_lecturer

      it 'is forbidden' do
        get students_thesis_proposals_path

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is a student' do
      subject { get students_thesis_proposals_path }

      include_context :signed_in_as_student

      let!(:faculty_approved_proposals) do
        create_list :thesis_proposal, 2, status: :faculty_approved, semester: current_semester
      end
      let!(:department_approved_proposals) do
        create_list :thesis_proposal, 2, status: :department_approved, semester: current_semester
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

      it 'does not show proposals which are waiting for approval' do
        subject

        expect(response.body).not_to include(*waiting_for_approval_proposals.map(&:to_s))
      end

      it 'does not show proposals from previous semesters' do
        subject

        expect(response.body).not_to include(previous_semester.to_s)
      end
    end
  end
end
