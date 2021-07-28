# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committees
#
#  id            :bigint           not null, primary key
#  session       :integer          default("inactive")
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
    association :department
    association :semester

    transient do
      chairman  { create :lecturer, department: department }
      secretary { create :lecturer, department: department }
      peer { create :lecturer, department: department }
    end

    after(:create) do |committee, options|
      committee.members.create(lecturer: options.chairman, role: :chairman)
      committee.members.create(lecturer: options.secretary, role: :secretary)
      committee.members.create(lecturer: options.peer, role: :peer)
    end
  end
end
