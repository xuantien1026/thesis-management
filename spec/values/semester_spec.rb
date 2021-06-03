# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester do
  describe '#to_s' do
    context 'when initialized with no argument' do
      it 'finds the current semester from db' do
        SemesterTime.create semester_number: 2, school_year: 2019, start_date: Time.zone.yesterday
        SemesterTime.create semester_number: 1, school_year: 2020, start_date: Time.zone.today

        semester = Semester.new

        expect(semester.to_s).to eq 'Học kì 1 (2020-2021)'
      end
    end

    context 'when initialized with semester number and year' do
      it 'works' do
        semester = Semester.new 1, 2020

        expect(semester.to_s).to eq 'Học kì 1 (2020-2021)'
      end
    end
  end
end
