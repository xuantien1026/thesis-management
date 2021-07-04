# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentManagement::DefenseCommitteesController, type: :request do
  describe 'GET /department_management/defense_committees' do
    subject { get dept_defense_committees_path }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    let!(:committee) { create :defense_committee, department: current_department, semester: current_semester }
    let!(:another_department_committee) { create :defense_committee, department: another_department, semester: current_semester }
    let!(:another_semester_committee) { create :defense_committee, department: current_department, semester: another_semester }

    let(:another_department) { create :department }
    let(:another_semester) { create :semester, start_date: current_semester.start_date - 1 }

    it 'works' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'show current department name' do
      subject

      expect(response.body).to include(current_department.to_s)
    end

    it 'show current semester' do
      subject

      expect(response.body).to include(current_semester.to_s)
    end

    it 'shows committees under current department & current semester' do
      subject

      expect(response.body).to include(committee.chairman.to_s)
    end

    it 'does not show committees from other semester' do
      subject

      expect(response.body).not_to include(another_semester_committee.chairman.to_s)
    end

    it 'does not show committees from other department' do
      subject

      expect(response.body).not_to include(another_department_committee.chairman.to_s)
    end
  end

  describe 'GET /department_management/defense_committees/suggest' do
    subject { get suggest_dept_defense_committees_path }

    include_context :signed_in_as_head_of_department

    it 'works' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end
end
