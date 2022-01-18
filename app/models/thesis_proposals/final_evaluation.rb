# == Schema Information
#
# Table name: thesis_proposal_final_evaluations
#
#  id                 :bigint           not null, primary key
#  note               :string
#  result             :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  thesis_proposal_id :bigint           not null
#
# Indexes
#
#  index_thesis_proposal_final_evaluations_on_thesis_proposal_id  (thesis_proposal_id)
#
module ThesisProposals
  class FinalEvaluation < ApplicationRecord
    belongs_to :thesis_proposal

    enum result: [:passed, :failed]
  end
end
