# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentManagement::LecturersController, type: :request do
  describe 'GET /department_management/lecturers' do
    subject { get dept_lecturers_path }

    it_behaves_like :department_management_authorized

    include_context :signed_in_as_head_of_department

    let!(:lecturers) { create_list :lecturer, 3, department: current_department }
    let!(:lecturer_from_other_department) { create :lecturer }

    it 'shows all lecturers in current department' do
      subject

      expect(response.body).to include(*lecturers.map(&:to_s))
    end

    it 'does not show lecturers in other departments' do
      subject

      expect(response.body).not_to include(lecturer_from_other_department.to_s)
    end
  end
end
