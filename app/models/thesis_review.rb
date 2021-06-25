# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_reviews
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lecturer_id :bigint
#  thesis_id   :bigint
#
# Indexes
#
#  index_thesis_reviews_on_lecturer_id  (lecturer_id)
#  index_thesis_reviews_on_thesis_id    (thesis_id)
#
class ThesisReview < ApplicationRecord
  belongs_to :thesis
  belongs_to :lecturer
end
