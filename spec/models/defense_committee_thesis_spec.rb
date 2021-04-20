# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committee_theses
#
#  id                   :bigint           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  defense_committee_id :bigint
#  thesis_id            :bigint
#
# Indexes
#
#  index_defense_committee_theses_on_defense_committee_id  (defense_committee_id)
#  index_defense_committee_theses_on_thesis_id             (thesis_id)
#
# Foreign Keys
#
#  fk_rails_...  (defense_committee_id => defense_committees.id)
#  fk_rails_...  (thesis_id => theses.id)
#
require 'rails_helper'

RSpec.describe DefenseCommitteeThesis, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
