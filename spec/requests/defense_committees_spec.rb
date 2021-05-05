# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DefenseCommittees', type: :request do
  describe 'POST /defense_committees' do
    let(:chairman) { create :lecturer }
    let(:secretary) { create :lecturer }
    let(:members) { create_list :lecturer, 2 }
    let(:theses) { create_list :thesis, 2 }

    context 'when user is head of department' do
      include_context :signed_in_as_head_of_department

      it 'creates new thesis defense committee' do
        post defense_committees_path, params: {
          defense_committee_form: {
            chairman_id: chairman.id,
            secretary_id: secretary.id,
            member_ids: members.map(&:id),
            thesis_ids: theses.map(&:id)
          }
        }

        new_committee = DefenseCommittee.last
        expect(new_committee.chairman).to eq(chairman)
        expect(new_committee.secretary).to eq(secretary)
        expect(new_committee.members).to contain_exactly(*members)
        expect(new_committee.theses).to contain_exactly(*theses)
      end
    end
  end
end
