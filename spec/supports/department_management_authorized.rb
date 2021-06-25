# frozen_string_literal: true

RSpec.shared_examples :department_management_authorized do
  context 'when current user is a student' do
    include_context :signed_in_as_student

    it 'returns forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when current user is a lecturer, but does not have head of department role' do
    include_context :signed_in_as_lecturer

    it 'returns forbidden' do
      subject

      expect(response).to have_http_status(:forbidden)
    end
  end
end
