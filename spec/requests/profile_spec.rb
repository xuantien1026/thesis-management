# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  describe 'GET /profile' do
    context 'when user is a student' do
      include_context :signed_in_as_student

      it 'shows student information' do
        get profile_path
        std_info = [student.name, student.mssv, student.email, student.dkmh, student.education_program, student.major]

        expect(response.body).to include(*std_info.map(&:to_s))
      end
    end

    context 'when user is a lecturer' do
      include_context :signed_in_as_lecturer

      it 'shows lecturer information' do
        get profile_path
        lecturer_info = [
          signed_lecturer.name,
          signed_lecturer.mscb,
          signed_lecturer.email,
          signed_lecturer.department,
          signed_lecturer.faculty,
        ]

        expect(response.body).to include(*lecturer_info.map(&:to_s))
      end
    end
  end
end
