# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplyTopic, type: :interactor do
  subject(:context) { ApplyTopic.call(student: student, topic: thesis_proposal) }

  context 'when topic already has max number of students' do
    let(:student) { create(:student) }
    let(:thesis_proposal) { create(:thesis_proposal, max_student_count: 2) }

    before do
      2.times { thesis_proposal.create_member(create(:student)) }
    end

    it 'fails' do
      expect(context).to be_a_failure
    end

    it 'gives useful error message' do
      expect(context.errors).to include('Đề tài đã đủ số sinh viên đăng kí')
    end
  end

  context 'when student has already applied' do
    let(:thesis_proposal) { create :thesis_proposal, students: [student] }
    let(:student) { create :student }

    it 'fails' do
      expect(context).to be_a_failure
    end

    it 'gives instruction on how to apply for a new topic' do
      expect(context.errors).to include('Bạn cần huỷ đề tài đã đăng kí để đăng kí mới')
    end
  end

  context 'when student has not applied for any topic' do
    let(:student) { create :student, dkmh: 'DCLV', major: 'CS', education_program: 'CQ' }
    let(:thesis_proposal) { create :thesis_proposal, majors: ['CS'], education_program: 'CQ' }

    it 'succeeds' do
      expect(context).to be_a_success
    end
  end
end
