# frozen_string_literal: true

# == Schema Information
#
# Table name: major_committees
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  major_id   :bigint
#
# Indexes
#
#  index_major_committees_on_major_id  (major_id)
#
# Foreign Keys
#
#  fk_rails_...  (major_id => majors.id)
#
class MajorCommittee < ApplicationRecord
  belongs_to :major

  has_many :members, dependent: :destroy
  has_many :lecturers, through: :members

  def to_s
    name
  end
end
