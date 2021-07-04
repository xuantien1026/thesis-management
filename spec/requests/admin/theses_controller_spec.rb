# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ThesesController, type: :request do
  include_context :signed_in_as_admin

  describe 'GET /faculties/:faculty_id/theses' do
    let(:advisors) { create_list :lecturer, 2, department: current_department }
    let(:another_department) { create :department, faculty: current_faculty }
    let(:advisors_from_another_department) { create_list :lecturer, 2, department: another_department }
    let!(:theses) do
      [
        (create :thesis, primary_advisor: advisors.first),
        (create :thesis, primary_advisor: advisors.second),
        (create :thesis, primary_advisor: advisors_from_another_department.first),
        (create :thesis, primary_advisor: advisors_from_another_department.second)
      ]
    end
    let(:theses_from_other_faculty) { create_list :thesis, 2 }

    it 'returns all theses of specified faculty' do
      get faculty_theses_path(current_faculty)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(*theses.map(&:to_s))
    end

    it 'does not show theses from other faculty' do
      get faculty_theses_path(current_faculty)

      expect(response.body).not_to include(*theses_from_other_faculty.map(&:to_s))
    end

    it 'returns all theses of specified lecturer when searched by lecturer' do
      get faculty_theses_path(current_faculty), params: { q: { advisors_lecturer_id_in: [advisors.map(&:id)] } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(theses.first.to_s)
      expect(response.body).to include(theses.second.to_s)
      expect(response.body).not_to include(theses.third.to_s)
    end
  end
end
