# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposal_advisors
#
#  id                 :bigint           not null, primary key
#  primary            :boolean          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lecturer_id        :bigint           not null
#  thesis_proposal_id :bigint           not null
#
# Indexes
#
#  index_thesis_proposal_advisors_on_lecturer_id         (lecturer_id)
#  index_thesis_proposal_advisors_on_thesis_proposal_id  (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (lecturer_id => users.id)
#  fk_rails_...  (thesis_proposal_id => thesis_proposals.id)
#
class ThesisProposalAdvisor < ApplicationRecord
  belongs_to :lecturer
  belongs_to :thesis_proposal
end
