# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThesesController, type: :request do
  describe 'GET /theses' do
    context 'when user is a lecturer' do
      include_context :signed_in_as_lecturer

      let!(:lecturer_theses) { create_list :thesis, 3, primary_advisor: signed_lecturer }
      let!(:theses_by_another_lecturer) { create_list :thesis, 3 }

      it 'shows theses which belongs to that lecturer' do
        get theses_path

        expect(response.body).to include(*lecturer_theses.map(&:to_s))
      end

      it 'does not show theses which belongs to other lecturers' do
        get theses_path

        expect(response.body).not_to include(*theses_by_another_lecturer.map(&:to_s))
      end
    end
  end

  describe 'GET /theses/:id' do
    let(:thesis) { create :thesis, :with_midterm_results, students: create_list(:student, 2) }

    context 'as a student' do
      include_context :signed_in_as_student

      it 'works' do
        get thesis_path(thesis)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'as a lecturer' do
      include_context :signed_in_as_lecturer

      it 'works' do
        get thesis_path(thesis)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
