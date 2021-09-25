# frozen_string_literal: true

# == Schema Information
#
# Table name: major_committee_members
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lecturer_id        :bigint
#  major_committee_id :bigint
#
# Indexes
#
#  index_major_committee_members_on_lecturer_id         (lecturer_id)
#  index_major_committee_members_on_major_committee_id  (major_committee_id)
#
# Foreign Keys
#
#  fk_rails_...  (lecturer_id => users.id)
#  fk_rails_...  (major_committee_id => major_committees.id)
#
class MajorCommittee
  class Member < ApplicationRecord
    belongs_to :major_committee
    belongs_to :lecturer
  end
end
