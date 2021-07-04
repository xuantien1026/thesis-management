# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committees_members
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
#  index_defense_committees_members_on_defense_committee_id  (defense_committee_id)
#  index_defense_committees_members_on_lecturer_id           (lecturer_id)
#
# Foreign Keys
#
#  fk_rails_...  (defense_committee_id => defense_committees.id)
#  fk_rails_...  (lecturer_id => users.id)
#

module DefenseCommittees
  class Member < ApplicationRecord
    belongs_to :defense_committee
    belongs_to :lecturer

    enum role: { 'peer' => 0, 'secretary' => 1, 'chairman' => 2 }
  end
end
