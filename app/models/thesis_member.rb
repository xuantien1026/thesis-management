# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_members
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#  thesis_id  :bigint
#
# Indexes
#
#  index_thesis_members_on_student_id  (student_id)
#  index_thesis_members_on_thesis_id   (thesis_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#
class ThesisMember < ApplicationRecord
  belongs_to :student
  belongs_to :thesis
  has_one :midterm_evaluation, dependent: :destroy

  delegate :name, to: :student
  delegate :mssv, to: :student
end
