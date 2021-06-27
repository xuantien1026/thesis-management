# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MidtermEvaluationsController, type: :request do
  describe 'GET /theses/:thesis_id/midterm_evaluations.pdf' do
    include_context :signed_in_as_lecturer

    let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

    it 'success' do
      get midterm_evaluations_path, params: { format: :pdf }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /theses/:thesis_id/midterm_evaluations/new' do
    include_context :signed_in_as_lecturer

    let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

    it 'success' do
      get new_midterm_evaluations_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /theses/midterm_evaluations' do
    subject { post midterm_evaluations_path, params: params }

    include_context :signed_in_as_lecturer

    let(:students) { create_list :student, 2 }
    let(:thesis) { create :thesis, primary_advisor: signed_lecturer, students: students }

    let(:students2) { create_list :student, 2 }
    let(:thesis2) { create :thesis, primary_advisor: signed_lecturer, students: students2 }

    let(:params) do
      {
        evaluations: {
          thesis.thesis_members.first.id => { passed: 0, note: '' },
          thesis.thesis_members.second.id => { passed: 1, note: '' },
          thesis2.thesis_members.first.id => { passed: 1, note: 'This is some midterm note' },
          thesis2.thesis_members.second.id => { passed: 1, note: '' }
        }
      }
    end

    it 'success' do
      subject

      expect(response).to have_http_status(:redirect)
    end

    it 'creates some midterm result objects' do
      expect { subject }.to change(MidtermEvaluation, :count).from(0).to(4)
    end
  end

  describe 'PUT /theses/:thesis_id/midterm_evaluations' do
    context 'when current user is a student' do
      include_context :signed_in_as_student

      let(:thesis) { create :thesis }

      it 'returns forbidden' do
        put thesis_midterm_evaluations_path(thesis)

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when thesis does not belongs to current lecturer' do
      include_context :signed_in_as_lecturer

      let(:another_lecturer) { create :lecturer }
      let(:thesis) { create :thesis, primary_advisor: another_lecturer }

      it 'returns forbidden' do
        put thesis_midterm_evaluations_path(thesis)

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when thesis does not have midterm evaluations yet' do
      include_context :signed_in_as_lecturer

      let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

      it 'returns forbidden' do
        put thesis_midterm_evaluations_path(thesis)

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when normal case' do
      include_context :signed_in_as_lecturer

      subject do
        put thesis_midterm_evaluations_path(thesis), params: {
          evaluations: {
            members.first.id => {
              passed: 'false',
              note: 'I input wrongly last time'
            },
            members.second.id => {
              passed: 'false',
              note: 'I input wrongly last time, this student fails midterm'
            }
          }
        }
      end

      let(:students) { create_list :student, 2 }
      let(:thesis) { create :thesis, :with_midterm_results, primary_advisor: signed_lecturer, students: students }
      let(:members) { thesis.thesis_members }

      it 'returns forbidden when lecturer is not granted update permission' do
        subject
        expect(response).to have_http_status(:forbidden)
      end

      it 'updates midterm evaluation results successfully when lecturer is granted privileged' do
        signed_lecturer.add_role :privileged_lecturer

        subject

        expect(thesis.midterm_evaluations.first.passed).to eq false
        expect(thesis.midterm_evaluations.second.passed).to eq false
      end
    end
  end
end
