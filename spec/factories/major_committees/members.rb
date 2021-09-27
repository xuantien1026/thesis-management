# frozen_string_literal: true

FactoryBot.define do
  factory :major_committee_member, class: 'MajorCommittee::Member' do
    association :major_committee
    association :lecturer
  end
end
