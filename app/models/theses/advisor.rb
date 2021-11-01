# frozen_string_literal: true

# == Schema Information
#
# Table name: theses_advisors
#
#  id          :bigint           not null, primary key
#  primary     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lecturer_id :bigint
#  thesis_id   :bigint
#
# Indexes
#
#  index_theses_advisors_on_lecturer_id  (lecturer_id)
#  index_theses_advisors_on_thesis_id    (thesis_id)
#
# Foreign Keys
#
#  fk_rails_...  (lecturer_id => users.id)
#  fk_rails_...  (thesis_id => theses.id)
#

module Theses
  class Advisor < ApplicationRecord
    belongs_to :thesis
    belongs_to :lecturer

    validates :lecturer_id, presence: true
  end
end
