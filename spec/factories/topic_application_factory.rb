# frozen_string_literal: true

# == Schema Information
#
# Table name: topic_applications
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  topic_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :topic_application do
    user
    topic
  end
end
