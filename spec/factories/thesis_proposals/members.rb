# frozen_string_literal: true

FactoryBot.define do
  factory :thesis_proposal_member, class: 'ThesisProposal::Member' do
    association :thesis_proposal
    association :student
  end
end
