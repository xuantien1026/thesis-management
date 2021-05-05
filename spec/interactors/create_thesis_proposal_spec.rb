# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateThesisProposal, type: :interactor do
  subject(:context) do
    CreateThesisProposal.call(thesis_proposal_params: thesis_proposal_params, students: students,
                              primary_advisor: primary_advisor)
  end

  let(:thesis_proposal_params) { attributes_for :thesis_proposal }
  let(:students) { create_list :student, 2 }
  let(:primary_advisor) { create :lecturer }

  context 'when proposal info is correct' do
    it { is_expected.to be_a_success }

    it 'create new topic' do
      expect { subject }.to change(ThesisProposal, :count).by(1)
    end

    it 'apply the students for the topic' do
      subject
      expect(ThesisProposalMember.where(student: students).count).to eq 2
    end
  end
end
