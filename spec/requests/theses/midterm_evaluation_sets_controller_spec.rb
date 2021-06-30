# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theses::MidtermEvaluationSetsController, type: :request do
  describe 'GET /theses/midterm_evaluation_set.pdf' do
    include_context :signed_in_as_lecturer

    let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

    it 'success' do
      get theses_midterm_evaluation_set_path, params: { format: :pdf }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /theses/:thesis_id/midterm_evaluation_set/new' do
    include_context :signed_in_as_lecturer

    let!(:thesis) { create :thesis, primary_advisor: signed_lecturer, students: create_list(:student, 2) }

    it 'success' do
      get new_theses_midterm_evaluation_set_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /theses/midterm_evaluation_set' do
    subject { post theses_midterm_evaluation_set_path, params: params }

    include_context :signed_in_as_lecturer

    let(:semester) { create :semester }

    let(:students) { create_list :student, 2 }
    let(:thesis) { create :thesis, primary_advisor: signed_lecturer, students: students, semester: semester }

    let(:students2) { create_list :student, 2 }
    let(:thesis2) { create :thesis, primary_advisor: signed_lecturer, students: students2, semester: semester }

    let(:params) do
      {
        theses_midterm_evaluation_set: {
          theses_midterm_evaluation: {
            thesis.members.first.id => { passed: 0, note: '' },
            thesis.members.second.id => { passed: 1, note: '' },
            thesis2.members.first.id => { passed: 1, note: 'This is some midterm note' },
            thesis2.members.second.id => { passed: 1, note: '' }
          }
        }
      }
    end

    it 'success' do
      subject

      expect(response).to have_http_status(:redirect)
    end

    it 'creates some midterm result objects' do
      expect { subject }.to change(Theses::MidtermEvaluation, :count).from(0).to(4)
    end
  end

  describe 'PUT /theses/midterm_evaluation_set' do
    subject { put theses_midterm_evaluation_set_path, params: params }

    context 'when user is a student' do
      include_context :signed_in_as_student

      let(:params) { {} }

      it 'is forbidden' do
        subject

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is a lecturer without privilege' do
      include_context :signed_in_as_lecturer

      let(:params) { {} }

      it 'is forbidden' do
        subject

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is a lecturer with privilege' do
      include_context :signed_in_as_lecturer

      let(:students) { create_list :student, 2 }
      let(:thesis) { create :thesis, :with_midterm_results, primary_advisor: signed_lecturer, students: students }

      let(:params) do
        {
          theses_midterm_evaluation_set: {
            theses_midterm_evaluation: {
              thesis.members.first.id => { passed: true, note: 'Very good' },
              thesis.members.second.id => { passed: false, note: 'Very bad' }
            }
          }
        }
      end

      before do
        signed_lecturer.add_role :privileged_lecturer
      end

      it 'updates evaluations' do
        subject

        expect(thesis.midterm_evaluations.count).to eq(2)
        expect(thesis.members.first.reload_midterm_evaluation.note).to eq('Very good')
        expect(thesis.members.second.reload_midterm_evaluation.note).to eq('Very bad')
      end
    end
  end
end
