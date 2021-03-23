# frozen_string_literal: true

class TopicApplication < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :user, uniqueness: true
end
