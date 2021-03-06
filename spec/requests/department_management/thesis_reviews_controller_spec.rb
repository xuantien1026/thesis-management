# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentManagement::Theses::ReviewsController, type: :request do
  describe 'GET /department_management/theses/:thesis_id/thesis_review' do
    subject { get dept_thesis_review_path(thesis) }

    let(:thesis) { create :thesis }
    let!(:review) { create :theses_review, thesis: thesis }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    it 'shows reviewer name for current thesis' do
      subject

      expect(response.body).to include(thesis.reviewer.to_s)
    end
  end

  describe 'GET /department_management/theses/:thesis_id/thesis_review/new' do
    subject { get new_dept_thesis_review_path(thesis) }

    let(:thesis) { create :thesis }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    it 'works' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /department_management/theses/:thesis_id/thesis_review' do
    subject { post dept_thesis_review_path(thesis), params: { theses_review: { lecturer_id: lecturer.id } } }

    let(:thesis) { create :thesis }
    let(:lecturer) { create :lecturer }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    it 'success' do
      subject

      expect(response).to have_http_status(:redirect)
    end

    it 'create new thesis review' do
      expect { subject }.to change(Theses::Review, :count).by(1)
    end
  end

  describe 'PUT /department_management/theses/:thesis_id/thesis_review' do
    subject { put dept_thesis_review_path(thesis), params: { theses_review: { lecturer_id: lecturer.id } } }

    let(:thesis) { create :thesis }
    let!(:review) { create :theses_review, thesis: thesis }
    let(:lecturer) { create :lecturer }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    it 'update reviewer' do
      subject

      expect(thesis.reviewer).to eq(lecturer)
    end
  end
end
