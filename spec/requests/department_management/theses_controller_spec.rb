# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentManagement::ThesesController, type: :request do
  describe 'GET /department_management/theses' do
    subject { get dept_theses_path }

    it_behaves_like :department_management_authorized

    context 'when current user is head of department' do
      include_context :signed_in_as_head_of_department

      let(:department) { head_of_department.department }
      let!(:thesis_of_current_department) do
        3.times.map do
          lecturer = create :lecturer, department: department
          create :thesis, primary_advisor: lecturer
        end
      end
      let!(:thesis_of_other_department) { create :thesis }

      it 'shows theses which belong to current department' do
        get dept_theses_path

        expect(response.body).to include(*thesis_of_current_department.map(&:to_s))
      end

      it 'does not show theses which do not belong to current department' do
        get dept_theses_path

        expect(response.body).not_to include(thesis_of_other_department.to_s)
      end
    end
  end
end
