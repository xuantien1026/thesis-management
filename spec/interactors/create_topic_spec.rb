# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateTopic, type: :interactor do
  subject(:context) { CreateTopic.call(topic_params: topic_params, students: students) }

  let(:topic_params) { attributes_for :topic }
  let(:students) { create_list :user, 2, :as_student }

  context 'when one of the students already applied for other topics' do
    before do
      create :topic_application, user: students.first, topic: (create :topic)
    end

    it 'fails' do
      expect(context).to be_a_failure
    end

    it 'returns error message' do
      expect(context.errors).to include("Sinh viên #{students.first.name} đã đăng kí đề tài khác")
    end
  end

  context 'when topics info is correct, and no students have applied for any topic' do
    it { is_expected.to be_a_success }

    it 'create new topic' do
      expect { subject }.to change(Topic, :count).by(1)
    end

    it 'apply the students for the topic' do
      subject
      expect(TopicApplication.where(user: students).count).to eq 2
    end
  end
end
