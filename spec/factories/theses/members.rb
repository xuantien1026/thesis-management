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
FactoryBot.define do
  factory :theses_member, class: 'Theses::Member' do
    association :thesis
    association :student
  end
end
