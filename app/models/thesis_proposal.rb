# frozen_string_literal: true

class ThesisProposal < ApplicationRecord
  belongs_to :topic

  delegate :title, :description, :primary_advisor, :program, :mission, :students, to: :topic
end
