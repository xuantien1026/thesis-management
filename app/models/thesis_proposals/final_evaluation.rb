# == Schema Information
#
# Table name: thesis_proposals_final_evaluations
#
#  id         :bigint           not null, primary key
#  note       :string
#  result     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :bigint           not null
#
# Indexes
#
#  index_thesis_proposals_final_evaluations_on_member_id  (member_id)
#
module ThesisProposals
  class FinalEvaluation < ApplicationRecord
    belongs_to :member

    enum result: [:passed, :failed]
  end
end
