# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicApplicationsController, type: :controller do
  describe 'POST /topics/:topic_id/topic_applications' do
    context 'when user is not a Student' do
      include_context :signed_in_as_lecturer

      let(:topic) { create :topic }

      it 'returns 403 forbidden' do
        post :create, params: { topic_id: topic.id }

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is a Student' do
      include_context :signed_in_as_student

      let(:max_students) { 3 }
      let(:topic) { create :topic, number_of_students: max_students }

      context 'when topic can still receive more students' do
        it 'successfully applies for the topic' do
          post :create, params: { topic_id: topic.id }

          expect(TopicApplication.where(user: student, topic: topic)).to exist
        end
      end

      context 'when topic is already at maximum number of students' do
        it 'fails to apply for the topic' do
          create_list :topic_application, max_students, topic: topic

          post :create, params: { topic_id: topic.id }

          expect(TopicApplication.where(user: student, topic: topic)).not_to exist
        end
      end
    end
  end
end
