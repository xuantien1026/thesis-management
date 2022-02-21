# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id            :bigint           not null, primary key
#  academic_year :integer          not null
#  end_date      :date
#  number        :integer          not null
#  start_date    :date             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Semester, type: :model do
  describe '#to_s' do
    it 'returns vietnamese string representation' do
      semester = create :semester, number: 1, academic_year: 2020, start_date: Time.zone.today

      expect(semester.to_s).to eq('Học kì 1 (2020-2021)')
    end
  end
end
