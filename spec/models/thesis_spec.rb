# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id                   :bigint           not null, primary key
#  assignment_date      :date
#  completion_date      :date
#  description          :text
#  education_program    :string
#  english_title        :string
#  majors               :string           default([]), is an Array
#  max_student_count    :integer          default(1), not null
#  mission              :text
#  ordering             :integer
#  references           :string           default([]), is an Array
#  status               :integer          default("waiting_for_approval")
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  defense_committee_id :bigint
#  semester_id          :bigint           not null
#  thesis_proposal_id   :bigint
#
# Indexes
#
#  index_theses_on_defense_committee_id  (defense_committee_id)
#  index_theses_on_semester_id           (semester_id)
#  index_theses_on_thesis_proposal_id    (thesis_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (defense_committee_id => defense_committees.id)
#  fk_rails_...  (semester_id => semesters.id)
#
require 'rails_helper'

RSpec.describe Thesis, type: :model do
  subject { create :thesis, primary_advisor: primary_advisor }

  let(:primary_advisor) { create :lecturer }

  describe '#department' do
    it 'is the department of primary advisor' do
      expect(subject.department).to eq(primary_advisor.department)
    end
  end

  describe '#faculty' do
    it 'is the faculty of primary advisor' do
      expect(subject.faculty).to eq(primary_advisor.faculty)
    end
  end

  describe '#major' do
    it 'is the majors specified when thesis is created, joined if multiple' do
      expect(subject.major).to eq(subject.majors.join(' - '))
    end
  end
end
