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
require 'rails_helper'

RSpec.describe Theses::CommitteeEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
