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
require 'rails_helper'

RSpec.describe DefenseCommitteeMember, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
