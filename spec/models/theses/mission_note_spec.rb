# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theses::MissionNote, type: :model do
  subject { Theses::MissionNote.new(thesis) }

  let(:thesis) { create :thesis }

  describe '#faculty' do
    it 'is faculty of the selected thesis' do
      expect(subject.faculty).to eq(thesis.faculty)
    end
  end

  describe '#department' do
    it 'is department of the selected thesis' do
      expect(subject.department).to eq(thesis.department)
    end
  end

  describe '#students' do
    it 'is the students who are working on this thesis' do
      expect(subject.students).to eq(thesis.students)
    end
  end

  describe '#major' do
    it 'is the major of the thesis' do
      expect(subject.major).to eq(thesis.major)
    end
  end

  describe '#school_class' do
    it 'is not implemented' do
      expect { subject.school_class }.to raise_error(NotImplementedError)
    end
  end

  describe '#title' do
    it 'is title of the selected thesis' do
      expect(subject.title).to eq(thesis.title)
    end
  end

  describe '#mission' do
    it 'is mission of the selected thesis' do
      expect(subject.mission).to eq(thesis.mission)
    end
  end

  describe '#assignment_date' do
    it 'is assignment_date of the selected thesis' do
      expect(subject.assignment_date).to eq(thesis.assignment_date)
    end
  end

  describe '#completion_date' do
    it 'is completion_date of the selected thesis' do
      expect(subject.completion_date).to eq(thesis.completion_date)
    end
  end

  describe '#advisors' do
    it 'is the advisors of the selected thesis' do
      raise pending 'To be implemented'
      # expect(subject.advisors).to eq(thesis.advisors)
    end
  end

  describe '#head_of_department' do
    it 'is head of department of the selected thesis' do
      expect(subject.head_of_department).to eq(thesis.department.head)
    end
  end

  describe '#primary_advisor' do
    it 'is the primary advisor of the selected thesis' do
      expect(subject.primary_advisor).to eq(thesis.primary_advisor)
    end
  end
end
