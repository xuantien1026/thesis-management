# == Schema Information
#
# Table name: thesis_proposals_reviewer_evaluations
#
#  id                 :bigint           not null, primary key
#  a1                 :integer          not null
#  a2                 :integer          not null
#  b1                 :integer          not null
#  b2                 :integer          not null
#  c1                 :integer          not null
#  c2                 :integer          not null
#  d1                 :integer          not null
#  d2                 :integer          not null
#  e1                 :integer          not null
#  e2                 :text
#  evaluation_date    :date             not null
#  thesis_proposal_id :bigint           not null
#
# Indexes
#
#  index_tp_reviewer_eval_on_tp_id  (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (thesis_proposal_id => thesis_proposals.id)
#
module ThesisProposals
  class ReviewerEvaluation < ApplicationRecord
    belongs_to :thesis_proposal

    enum a1: %w[a b c d], _prefix: true
    enum a2: %w[a b c d], _prefix: true
    enum b1: %w[a b c d], _prefix: true
    enum b2: %w[a b c d], _prefix: true
    enum c1: %w[a b c d], _prefix: true
    enum c2: %w[a b c d], _prefix: true
    enum d1: %w[a b c d], _prefix: true
    enum d2: %w[a b c d], _prefix: true
    enum e1: %w[a b c d], _prefix: true

    validates :a1, :a2, :b1, :b2, :c1, :c2, :d1, :d2, :e1, presence: true
  end
end
