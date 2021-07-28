# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_advisor_evaluations
#
#  id                        :bigint           not null, primary key
#  bonus_point               :integer
#  bonus_reason              :string
#  learning_outcome1         :string
#  learning_outcome10        :string
#  learning_outcome10_remark :string
#  learning_outcome11        :string
#  learning_outcome11_remark :string
#  learning_outcome12        :string
#  learning_outcome12_remark :string
#  learning_outcome13        :string
#  learning_outcome13_remark :string
#  learning_outcome14        :string
#  learning_outcome14_remark :string
#  learning_outcome15        :string
#  learning_outcome15_remark :string
#  learning_outcome1_remark  :string
#  learning_outcome2         :string
#  learning_outcome2_remark  :string
#  learning_outcome3         :string
#  learning_outcome3_remark  :string
#  learning_outcome4         :string
#  learning_outcome4_remark  :string
#  learning_outcome5         :string
#  learning_outcome5_remark  :string
#  learning_outcome6         :string
#  learning_outcome6_remark  :string
#  learning_outcome7         :string
#  learning_outcome7_remark  :string
#  learning_outcome8         :string
#  learning_outcome8_remark  :string
#  learning_outcome9         :string
#  learning_outcome9_remark  :string
#  marking1                  :integer
#  marking2                  :integer
#  marking3                  :integer
#  marking4                  :integer
#  marking5                  :integer
#  marking6                  :integer
#  marking7                  :integer
#  marking8                  :integer
#  marking9                  :integer
#  opinion_about_form        :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  theses_member_id          :bigint
#
# Indexes
#
#  index_theses_advisor_evaluations_on_theses_member_id  (theses_member_id)
#
# Foreign Keys
#
#  fk_rails_...  (theses_member_id => theses_members.id)
#
FactoryBot.define do
  factory :theses_advisor_evaluation, class: 'Theses::AdvisorEvaluation' do
    association :member
    marking1 { 1 }
    marking2 { 1 }
    marking3 { 1 }
    marking4 { 1 }
    marking5 { 1 }
    marking6 { 1 }
    marking7 { 1 }
    marking8 { 1 }
    marking9 { 1 }
    bonus_point { 0 }
    bonus_reason { 'Good student' }
    learning_outcome1 { 'A' }
    learning_outcome2 { 'A' }
    learning_outcome3 { 'A' }
    learning_outcome4 { 'A' }
    learning_outcome5 { 'A' }
    learning_outcome6 { 'A' }
    learning_outcome7 { 'A' }
    learning_outcome8 { 'A' }
    learning_outcome9 { 'A' }
    learning_outcome10 { 'A' }
    learning_outcome11 { 'A' }
    learning_outcome12 { 'A' }
    learning_outcome13 { 'A' }
    learning_outcome14 { 'A' }
    learning_outcome15 { 'A' }
    opinion_about_form { 'This form is good' }
  end
end
