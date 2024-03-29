# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_members
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#  thesis_id  :bigint
#
# Indexes
#
#  index_theses_members_on_student_id  (student_id)
#  index_theses_members_on_thesis_id   (thesis_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#
module Theses
  class Member < ApplicationRecord
    belongs_to :student
    belongs_to :thesis
    has_one :midterm_evaluation, dependent: :destroy
    has_one :advisor_evaluation, dependent: :destroy, foreign_key: 'theses_member_id',
                                 inverse_of: :member
    has_one :reviewer_evaluation, dependent: :destroy, foreign_key: 'theses_member_id',
                                  inverse_of: :member
    has_many :committee_evaluations do
      def by(committee_member)
        find_by(committee_member: committee_member)
      end
    end

    delegate :name, :mssv, to: :student

    def final_average
      total_score = advisor_evaluation&.total_marking.to_i + reviewer_evaluation&.total_marking.to_i + committee_evaluations.sum(&:total_marking)
      total_count = committee_evaluations.length
      total_count += 1 if advisor_evaluation
      total_count += 1 if reviewer_evaluation
      total_count.zero? ? 0 : total_score / total_count
    end
  end
end
