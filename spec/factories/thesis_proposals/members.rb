# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals_members
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  student_id         :bigint
#  thesis_proposal_id :bigint
#
# Indexes
#
#  index_thesis_proposals_members_on_student_id          (student_id)
#  index_thesis_proposals_members_on_thesis_proposal_id  (thesis_proposal_id)
#
FactoryBot.define do
  factory :thesis_proposal_member, class: 'ThesisProposal::Member' do
    association :thesis_proposal
    association :student
  end
end
