# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples :reviewer_authorized do
  context 'when user is a student' do
    include_context :signed_in_as_student

    it 'is forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when current lecturer is not the reviewer of the thesis' do
    include_context :signed_in_as_lecturer

    it 'is forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end
end

RSpec.describe Theses::ReviewerEvaluationsController, type: :request do
  let(:thesis) { create :thesis }
  let(:member) { create :theses_member, thesis: thesis }

  describe 'GET /theses/members/:member_id/reviewer_evaluation/new' do
    subject { get new_theses_member_reviewer_evaluation_path(member) }

    it_behaves_like :reviewer_authorized

    context 'when current lecturer is the reviewer of the thesis' do
      include_context :signed_in_as_lecturer

      before do
        create :theses_review, thesis: thesis, lecturer: signed_lecturer
      end

      it 'works' do
        subject

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /theses/members/:member_id/reviewer_evaluation' do
    subject { post theses_member_reviewer_evaluation_path(member), params: params }

    let(:params) do
      {
        theses_reviewer_evaluation: attributes_for(:theses_reviewer_evaluation).merge(theses_member_id: member.id)
      }
    end

    it_behaves_like :reviewer_authorized

    context 'when current lecturer is the reviewer of the thesis' do
      include_context :signed_in_as_lecturer

      before do
        create :theses_review, thesis: thesis, lecturer: signed_lecturer
      end

      it 'works' do
        subject

        expect(response).to have_http_status(:redirect)
      end

      it 'create advisor evaluation for the selected member' do
        expect { subject }.to change(Theses::ReviewerEvaluation, :count).from(0).to(1)
      end
    end
  end

  describe 'GET /theses/members/:member_id/reviewer_evaluation/edit' do
    subject { get edit_theses_member_reviewer_evaluation_path(member) }

    it_behaves_like :reviewer_authorized

    context 'when current lecturer is the reviewer of the thesis' do
      include_context :signed_in_as_lecturer

      before do
        create :theses_review, thesis: thesis, lecturer: signed_lecturer
        create :theses_reviewer_evaluation, member: member
      end

      it 'works' do
        subject

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT /theses/members/:member_id/reviewer_evaluation' do
    subject { put theses_member_reviewer_evaluation_path(member), params: params }

    let(:params) do
      {
        theses_reviewer_evaluation: attributes_for(:theses_reviewer_evaluation).merge(theses_member_id: member.id, marking1: 50)
      }
    end

    it_behaves_like :reviewer_authorized

    context 'when current lecturer is the reviewer of the thesis' do
      include_context :signed_in_as_lecturer

      let(:evaluation) { member.reviewer_evaluation }

      before do
        create :theses_review, thesis: thesis, lecturer: signed_lecturer
        create :theses_reviewer_evaluation, member: member
      end

      it 'works' do
        subject

        expect(response).to have_http_status(:redirect)
      end

      it 'create advisor evaluation for the selected member' do
        subject

        expect(evaluation.reload.marking1).to eq(50)
      end
    end
  end
end
