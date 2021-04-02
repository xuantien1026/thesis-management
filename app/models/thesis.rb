class Thesis < ApplicationRecord
  belongs_to :thesis_proposal

  delegate :title, :description, :primary_advisor, :program, :mission, :students, to: :thesis_proposal
end
