# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_reviewer_evaluations
#
#  id                       :bigint           not null, primary key
#  bonus_point              :integer
#  bonus_reason             :string
#  learning_outcome1        :string
#  learning_outcome1_remark :string
#  learning_outcome2        :string
#  learning_outcome2_remark :string
#  learning_outcome3        :string
#  learning_outcome3_remark :string
#  learning_outcome4        :string
#  learning_outcome4_remark :string
#  learning_outcome5        :string
#  learning_outcome5_remark :string
#  learning_outcome6        :string
#  learning_outcome6_remark :string
#  learning_outcome7        :string
#  learning_outcome7_remark :string
#  learning_outcome8        :string
#  learning_outcome8_remark :string
#  learning_outcome9        :string
#  learning_outcome9_remark :string
#  marking1                 :integer
#  marking2                 :integer
#  marking3                 :integer
#  marking4                 :integer
#  marking5                 :integer
#  marking6                 :integer
#  marking7                 :integer
#  marking8                 :integer
#  marking9                 :integer
#  opinion_about_form       :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  theses_member_id         :bigint
#
# Indexes
#
#  index_theses_reviewer_evaluations_on_theses_member_id  (theses_member_id)
#
# Foreign Keys
#
#  fk_rails_...  (theses_member_id => theses_members.id)
#
module Theses
  class ReviewerEvaluation < ApplicationRecord
    belongs_to :member, foreign_key: :theses_member_id, inverse_of: :reviewer_evaluation

    LEARNING_OUTCOME_ATTRS = (1..9).map { |i| "learning_outcome#{i}" }
    MARKING_ATTRS = (1..9).map { |i| "marking#{i}" }

    validates(*MARKING_ATTRS, presence: true)
    validates(*LEARNING_OUTCOME_ATTRS, presence: true)
    validates :marking1, inclusion: 0..50
    validates :marking2, :marking3, :marking6, :marking7, :marking8, :marking9, inclusion: 0..5
    validates :marking4, :marking5, inclusion: 0..10
    validates :bonus_point, inclusion: 0..10, allow_nil: true

    def total_marking
      (MARKING_ATTRS.map { |attr| send(attr) }.sum + bonus_point.to_i).clamp(0, 100)
    end

    def bookmarks # rubocop:disable Metrics/MethodLength
      thesis = member.thesis
      reviewer = thesis.reviewer
      semester = thesis.semester

      attributes.except('id', 'theses_member_id', 'created_at', 'updated_at').merge(
        total_marking: total_marking,
        semester: semester.number,
        year: semester.year,
        reviewer: reviewer.name,
        member: member.name,
        mssv: member.mssv,
        thesis: thesis.to_s
      )
    end
  end
end
