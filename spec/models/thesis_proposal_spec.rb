# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals
#
#  id                :bigint           not null, primary key
#  description       :text
#  education_program :string
#  english_title     :string
#  max_student_count :integer          default(1), not null
#  mission           :string
#  ordering          :integer
#  references        :string           default([]), is an Array
#  status            :integer          default("waiting_for_approval")
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  major_id          :bigint           not null
#  semester_id       :bigint           not null
#
# Indexes
#
#  index_thesis_proposals_on_major_id     (major_id)
#  index_thesis_proposals_on_semester_id  (semester_id)
#
# Foreign Keys
#
#  fk_rails_...  (major_id => majors.id)
#  fk_rails_...  (semester_id => semesters.id)
#
require 'rails_helper'

RSpec.describe ThesisProposal, type: :model do
  subject { create :thesis_proposal, primary_advisor: primary_advisor }

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
    it 'is the majors specified when thesis proposal is created, joined if multiple' do
      expect(subject.major).to eq(subject.majors.join(' - '))
    end
  end
end
