require 'rails_helper'

RSpec.describe ApplyTopic, type: :interactor do
  subject(:context) { ApplyTopic.call(student: student, topic: topic) }

  describe '.call' do
    context 'when topic already has max number of students' do
      let(:student) { double(:student) }
      let(:topic) { double(:topic, available_for_application?: false) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'gives useful error message' do
        expect(context.error).to eq('Đề tài đã đủ số sinh viên đăng kí')
      end
    end

    context 'when student has already applied' do
      let(:topic) { create :topic }
      let(:student) { create(:topic_application).user }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'gives instruction on how to apply for a new topic' do
        expect(context.error).to eq('Bạn cần huỷ đề tài đã đăng kí để đăng kí mới')
      end
    end

    context 'when student has not applied for any topic' do
      let(:student) { create :user, :as_student }
      let(:topic) { create :topic }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end
  end
end
