# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposal_members
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  student_id         :bigint
#  thesis_proposal_id :bigint
#
# Indexes
#
#  index_thesis_proposal_members_on_student_id          (student_id)
#  index_thesis_proposal_members_on_thesis_proposal_id  (thesis_proposal_id)
#
class ThesisProposal
  class Member < ApplicationRecord
    belongs_to :student
    belongs_to :thesis_proposal
  end
end
