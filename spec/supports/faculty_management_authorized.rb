# frozen_string_literal: true

RSpec.shared_examples :faculty_management_authorized do
  context 'when current user is a student' do
    include_context :signed_in_as_student

    it 'returns forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when current user is a lecturer' do
    include_context :signed_in_as_lecturer

    it 'returns forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when current user is a head of department' do
    include_context :signed_in_as_head_of_department

    it 'returns forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end
end
