# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_reviews
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lecturer_id :bigint
#  thesis_id   :bigint
#
# Indexes
#
#  index_theses_reviews_on_lecturer_id  (lecturer_id)
#  index_theses_reviews_on_thesis_id    (thesis_id)
#
FactoryBot.define do
  factory :theses_review, class: 'Theses::Review' do
    association :thesis
    association :lecturer
  end
end
