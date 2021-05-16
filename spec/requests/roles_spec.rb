# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles', type: :request do
  describe 'POST /lecturers/:lecturer_id/roles' do
    let(:lecturer) { create :lecturer }

    context 'when user does not have authority (admin or super admin) to edit roles' do
      include_context :signed_in_as_lecturer

      it 'is forbidden' do
        post lecturer_role_path(lecturer), params: { roles: [:admin] }

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user has authority to edit roles' do
      include_context :signed_in_as_admin

      it 'returns success' do
        post lecturer_role_path(lecturer), params: { roles: [:admin] }

        expect(response).to have_http_status(:redirect)
      end

      it "modifies selected lecturer's role" do
        post lecturer_role_path(lecturer), params: { roles: %i[admin head_of_department] }

        expect(lecturer.is_admin?).to eq true
        expect(lecturer.is_head_of_department?).to eq true
        expect(lecturer.roles.count).to eq 2
      end

      it 'removes roles if none is selected' do
        post lecturer_role_path(lecturer)

        expect(lecturer.roles).to be_empty
      end
    end
  end
end
