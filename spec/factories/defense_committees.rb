# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committees
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :bigint
#  semester_id   :bigint
#
# Indexes
#
#  index_defense_committees_on_department_id  (department_id)
#  index_defense_committees_on_semester_id    (semester_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#  fk_rails_...  (semester_id => semesters.id)
#
FactoryBot.define do
  factory :defense_committee do
    name { 'MyString' }
    chairman_id { 1 }
    secretary_id { 1 }
  end
end
