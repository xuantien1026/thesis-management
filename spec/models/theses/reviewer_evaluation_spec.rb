# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_reviewer_evaluations
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
#  index_theses_reviewer_evaluations_on_theses_member_id  (theses_member_id)
#
# Foreign Keys
#
#  fk_rails_...  (theses_member_id => theses_members.id)
#
require 'rails_helper'

RSpec.describe Theses::ReviewerEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
