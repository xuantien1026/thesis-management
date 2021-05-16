# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester do
  describe '#to_s' do
    context 'when initialized with no argument' do
      it 'finds the current semester from db' do
        semester = Semester.new

        expect(semester.to_s).to eq 'Học kì 2 (2020-2021)'
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
