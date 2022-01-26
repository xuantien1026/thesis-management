# == Schema Information
#
# Table name: thesis_proposals_reviews
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lecturer_id        :bigint           not null
#  thesis_proposal_id :bigint           not null
#
# Indexes
#
#  index_thesis_proposals_reviews_on_lecturer_id         (lecturer_id)
#  index_thesis_proposals_reviews_on_thesis_proposal_id  (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (lecturer_id => users.id)
#  fk_rails_...  (thesis_proposal_id => thesis_proposals.id)
#
module ThesisProposals
  class Review < ApplicationRecord
    belongs_to :thesis_proposal
    belongs_to :lecturer
  end
end
