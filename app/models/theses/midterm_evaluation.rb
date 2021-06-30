# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_midterm_evaluations
#
#  id         :bigint           not null, primary key
#  note       :string
#  passed     :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :bigint           not null
#
# Indexes
#
#  index_theses_midterm_evaluations_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => theses_members.id)
#
module Theses
  class MidtermEvaluation < ApplicationRecord
    belongs_to :member

    delegate :name, to: :member, prefix: :student
    delegate :mssv, to: :member, prefix: :student
  end
end
