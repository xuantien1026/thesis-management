# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_advisors
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
#  index_thesis_advisors_on_lecturer_id  (lecturer_id)
#  index_thesis_advisors_on_thesis_id    (thesis_id)
#
# Foreign Keys
#
#  fk_rails_...  (lecturer_id => users.id)
#  fk_rails_...  (thesis_id => theses.id)
#
require 'rails_helper'

RSpec.describe ThesisAdvisor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
