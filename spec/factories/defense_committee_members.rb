# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committee_members
#
#  id                   :bigint           not null, primary key
#  role                 :integer          default("member")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  defense_committee_id :bigint
#  lecturer_id          :bigint
#
# Indexes
#
#  index_defense_committee_members_on_defense_committee_id  (defense_committee_id)
#  index_defense_committee_members_on_lecturer_id           (lecturer_id)
#
# Foreign Keys
#
#  fk_rails_...  (defense_committee_id => defense_committees.id)
#  fk_rails_...  (lecturer_id => users.id)
#
FactoryBot.define do
  factory :defense_committee_member do
  end
end
