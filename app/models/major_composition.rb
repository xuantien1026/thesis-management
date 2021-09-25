# frozen_string_literal: true

# == Schema Information
#
# Table name: major_compositions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  multi_major_id  :bigint
#  single_major_id :bigint
#
# Indexes
#
#  index_major_compositions_on_multi_major_id   (multi_major_id)
#  index_major_compositions_on_single_major_id  (single_major_id)
#
# Foreign Keys
#
#  fk_rails_...  (multi_major_id => majors.id)
#  fk_rails_...  (single_major_id => majors.id)
#
class MajorComposition < ApplicationRecord
  belongs_to :multi_major
  belongs_to :single_major
end
