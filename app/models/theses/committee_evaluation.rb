# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_committee_evaluations
#
#  id                  :bigint           not null, primary key
#  bonus_point         :integer
#  bonus_reason        :text
#  marking1            :integer          not null
#  marking2            :integer          not null
#  marking3            :integer          not null
#  marking4            :integer          not null
#  marking5            :integer          not null
#  marking6            :integer          not null
#  marking7            :integer          not null
#  opinion_about_form  :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  committee_member_id :bigint           not null
#  member_id           :bigint           not null
#
# Indexes
#
#  index_theses_committee_evaluations_on_committee_member_id  (committee_member_id)
#  index_theses_committee_evaluations_on_member_id            (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (committee_member_id => defense_committees_members.id)
#  fk_rails_...  (member_id => theses_members.id)
#
module Theses
  class CommitteeEvaluation < ApplicationRecord
    belongs_to :committee_member, class_name: 'DefenseCommittees::Member'
    belongs_to :member

    TEMPLATE_PATH = 'app/documents/post_defense/phieu_danh_gia_LVTN_HD.docx'
    MARKING_ATTRS = (1..7).map { |i| "marking#{i}" }

    validates(*MARKING_ATTRS, presence: true)
    validates :marking1, inclusion: 0..50
    validates :marking2, :marking3, inclusion: 0..5
    validates :marking4, :marking5, :marking6, :marking7, inclusion: 0..10
    validates :bonus_point, inclusion: 0..10, allow_nil: true

    def total_marking
      (MARKING_ATTRS.map { |attr| send(attr) }.sum + bonus_point.to_i).clamp(0, 100)
    end
  end
end
