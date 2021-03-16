class ThesisApplication < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  enum status: [:pending, :approved, :rejected]
end
