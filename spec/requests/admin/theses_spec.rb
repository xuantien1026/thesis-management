# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminThesesManagement', type: :request do
  include_context :basic_faculty
  include_context :signed_in_as_admin

  describe 'GET /faculties/:faculty_id/theses' do
    let(:advisors) { create_list :lecturer, 2, department: department }
    let(:another_department) { create :department, faculty: faculty }
    let(:advisors_from_another_department) { create_list :lecturer, 2, department: another_department }
    let!(:theses) do
      [
        (create :thesis, primary_advisor: advisors.first),
        (create :thesis, primary_advisor: advisors.second),
        (create :thesis, primary_advisor: advisors_from_another_department.first),
        (create :thesis, primary_advisor: advisors_from_another_department.second)
      ]
    end

    it 'returns all theses of specified faculty' do
      get faculty_theses_path(faculty)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(*theses.map(&:to_s))
    end

    it 'returns all theses of specified lecturer when searched by lecturer' do
      get faculty_theses_path(faculty), params: { primary_advisor_ids: [advisors.map(&:id)] }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(theses.first.to_s)
      expect(response.body).to include(theses.second.to_s)
      expect(response.body).not_to include(theses.third.to_s)
    end
  end
end
