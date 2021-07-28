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
    has_one :midterm_evaluation, dependent: :restrict_with_exception
    has_one :advisor_evaluation, dependent: :restrict_with_exception, foreign_key: 'theses_member_id',
                                 inverse_of: :member
    has_one :reviewer_evaluation, dependent: :restrict_with_exception, foreign_key: 'theses_member_id',
                                  inverse_of: :member

    delegate :name, :mssv, to: :student
  end
end
