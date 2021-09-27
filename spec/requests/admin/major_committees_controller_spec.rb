# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::MajorCommitteesController, type: :request do
  include_context :signed_in_as_admin

  describe 'GET /admin/major_committees/:id' do
    subject { get admin_major_committee_path(major_committee) }

    let(:major_committee) { create :major_committee }
    let(:members) { create_list :major_committee_member, 3 }

    it { is_expected.to eq(200) }

    it 'shows members of the committees' do
      subject

      expect(response.body).to include(*members.map(&:name))
    end
  end
end
