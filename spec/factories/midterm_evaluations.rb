# frozen_string_literal: true

# == Schema Information
#
# Table name: midterm_evaluations
#
#  id               :bigint           not null, primary key
#  note             :string
#  passed           :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  thesis_member_id :bigint           not null
#
# Indexes
#
#  index_midterm_evaluations_on_thesis_member_id  (thesis_member_id)
#
# Foreign Keys
#
#  fk_rails_...  (thesis_member_id => thesis_members.id)
#
FactoryBot.define do
  factory :midterm_evaluation do
    thesis_membership { nil }
    passed { false }
    note { 'MyString' }
  end
end
