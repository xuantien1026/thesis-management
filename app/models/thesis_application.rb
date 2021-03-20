# frozen_string_literal: true

class ThesisApplication < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  enum status: { pending: 0, approved: 1, rejected: 2 }
end
