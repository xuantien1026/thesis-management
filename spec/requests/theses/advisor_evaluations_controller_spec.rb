# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples :primary_advisor_authorized do
  context 'when user is a student' do
    include_context :signed_in_as_student

    it 'is forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when current lecturer is not the primary advisor of the thesis' do
    include_context :signed_in_as_lecturer

    it 'is forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end
end

RSpec.describe Theses::AdvisorEvaluationsController, type: :request do
  let(:thesis) { create :thesis }
  let(:member) { create :theses_member, thesis: thesis }

  describe 'GET /theses/members/:member_id/advisor_evaluation/new' do
    subject { get new_theses_member_advisor_evaluation_path(member) }

    it_behaves_like :primary_advisor_authorized

    context 'when current lecturer is the primary advisor of the thesis' do
      include_context :signed_in_as_lecturer

      let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

      it 'works' do
        subject

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /theses/members/:member_id/advisor_evaluation' do
    subject { post theses_member_advisor_evaluation_path(member), params: params }

    let(:params) do
      {
        theses_advisor_evaluation: attributes_for(:theses_advisor_evaluation).merge(theses_member_id: member.id)
      }
    end

    it_behaves_like :primary_advisor_authorized

    context 'when current lecturer is the primary advisor of the thesis' do
      include_context :signed_in_as_lecturer

      let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

      it 'works' do
        subject

        expect(response).to have_http_status(:redirect)
      end

      it 'create advisor evaluation for the selected member' do
        expect { subject }.to change(Theses::AdvisorEvaluation, :count).from(0).to(1)
      end
    end
  end

  describe 'GET /theses/members/:member_id/advisor_evaluation/edit' do
    subject { get edit_theses_member_advisor_evaluation_path(member) }

    it_behaves_like :primary_advisor_authorized

    context 'when current lecturer is the primary advisor of the thesis' do
      include_context :signed_in_as_lecturer

      let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

      before do
        create :theses_advisor_evaluation, member: member
      end

      it 'works' do
        subject

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT /theses/members/:member_id/advisor_evaluation' do
    subject { put theses_member_advisor_evaluation_path(member), params: params }

    let(:params) do
      {
        theses_advisor_evaluation: attributes_for(:theses_advisor_evaluation).merge(theses_member_id: member.id,
                                                                                    marking1: 50)
      }
    end

    it_behaves_like :primary_advisor_authorized

    context 'when current lecturer is the primary advisor of the thesis' do
      include_context :signed_in_as_lecturer

      let(:thesis) { create :thesis, primary_advisor: signed_lecturer }

      before do
        create :theses_advisor_evaluation, member: member
      end

      it 'works' do
        subject

        expect(response).to have_http_status(:redirect)
      end

      it 'create advisor evaluation for the selected member' do
        subject

        expect(member.advisor_evaluation.reload.marking1).to eq(50)
      end
    end
  end
end
