# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topics', type: :request do
  describe 'GET /topics (Show topics for current user)' do
    context 'when user is a Student' do
      include_context :signed_in_as_student

      let!(:faculty_approved_topic_titles) { create_list(:topic, rand(1..5), status: :faculty_approved).map(&:title) }
      let!(:new_topic) { create :topic, status: :newly_created }
      let!(:department_approved_topic) { create :topic, status: :department_approved }

      it 'only faculty approved topics are visible to students' do
        get topics_path

        expect(response.body).to include(*faculty_approved_topic_titles)
      end

      it 'newly created topics by lecturer are not visible' do
        get topics_path

        expect(response.body).not_to include(new_topic.title)
      end

      it 'topics approved by department (not approved by faculty) are not visible' do
        get topics_path

        expect(response.body).not_to include(department_approved_topic.title)
      end
    end

    context 'when user is a Lecturer' do
      include_context :signed_in_as_lecturer

      let!(:my_topics) { create_list :topic, rand(1..5), status: :newly_created, primary_advisor: lecturer }
      let!(:other_people_topic) { create :topic, status: Topic.statuses.values.sample }

      it 'only my topics are visible' do
        get topics_path

        expect(response.body).to include(*my_topics.map(&:title))
      end

      it 'other lecturers topics are not visible' do
        get topics_path

        expect(response.body).not_to include(other_people_topic.title)
      end
    end

    context 'when user is Head of Department' do
      include_context :signed_in_as_head_of_department

      let(:my_department_lecturers) { create_list :user, 3, :as_lecturer, department: department }
      let!(:my_department_topics) do
        create_list :topic, rand(1..5), status: :newly_created, primary_advisor: my_department_lecturers.sample
      end
      let!(:other_department_topic) { create :topic, status: Topic.statuses.values.sample }

      it 'only topics of my department are visible' do
        get topics_path

        expect(response.body).to include(*my_department_topics.map(&:title))
      end

      it 'topics from other departments are not visible' do
        get topics_path

        expect(response.body).not_to include(other_department_topic.title)
      end
    end

    context 'when user is Head of Faculty' do
      include_context :signed_in_as_head_of_faculty

      let!(:department_approved_topics) { create_list :topic, rand(1..5), status: :department_approved }
      let!(:faculty_approved_topics) { create_list :topic, rand(1..5), status: :faculty_approved}
      let!(:unapproved_topic) { create :topic }

      it 'topics approved by department heads are visible' do
        get topics_path

        expect(response.body).to include(*department_approved_topics.map(&:title))
      end

      it 'topics approved by faculty are visible' do
        get topics_path

        expect(response.body).to include(*faculty_approved_topics.map(&:title))
      end

      it 'topics which are not yet approved by department heads are not visible' do
        get topics_path

        expect(response.body).not_to include(unapproved_topic.title)
      end
    end
  end

  describe 'POST /topics/:id/department_approve (Approval of a Topic by Head of Department)' do
    context 'when user is not head of any department' do
      include_context :signed_in_as_student

      let(:topic) { create :topic }

      it 'returns 403 forbidden' do
        post department_approve_topic_path(topic)

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is Head of Department' do
      include_context :signed_in_as_head_of_department

      context 'when topic belongs to another department' do
        let(:topic) { create :topic }

        it 'returns 403 forbidden' do
          post department_approve_topic_path(topic)

          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when topic belongs to the same department' do
        context 'when topic is still waiting for department approval' do
          let(:topic) { create :topic, department: department }

          it 'successfully transition topic into department approved' do
            post department_approve_topic_path(topic)

            expect(response).to redirect_to topics_path
          end
        end

        context 'when topic is already approved' do
          let(:topic) { create :topic, department: department, status: :department_approved }

          it 'returns 403 forbidden' do
            post department_approve_topic_path(topic)

            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end

  describe 'POST /topics/:id/faculty_approve (Approval of a Topic by Head of Faculty)' do
    context 'when user is not Head of Faculty' do
      include_context :signed_in_as_student

      let(:topic) { create :topic }

      it 'returns 403 forbidden' do
        post faculty_approve_topic_path(topic)

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is Head of Faculty' do
      include_context :signed_in_as_head_of_faculty

      context 'when topic is not yet approved by department' do
        let(:topic) { create :topic, status: :newly_created }

        it 'returns 403 forbidden' do
          post faculty_approve_topic_path(topic)

          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when topic is department approved, waiting for faculty approval' do
        let(:topic) { create :topic, status: :department_approved }

        it 'successfully transition topic into faculty approved' do
          post faculty_approve_topic_path(topic)

          expect(response).to redirect_to topics_path
        end
      end
    end
  end
end
