# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topics', type: :request do
  describe 'GET /topics' do
    context 'when user is a Student' do
      include_context :signed_in_as_student

      let!(:faculty_approved_topic_titles) { create_list(:topic, rand(1..5), status: :faculty_approved).map(&:title) }
      let!(:new_topic) { create :topic, status: :default }
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

      let!(:my_topics) { create_list :topic, rand(1..5), status: :default, primary_advisor: lecturer }
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
  end
end
