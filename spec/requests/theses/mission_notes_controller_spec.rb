# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theses::MissionNotesController, type: :request do
  describe 'GET /theses/:thesis_id/mission_note' do
    subject { get thesis_mission_note_path(thesis) }

    let(:thesis) { create :thesis }

    include_context :signed_in_as_lecturer

    it 'success' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end
end
