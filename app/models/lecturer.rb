# frozen_string_literal: true

class Lecturer < User
  belongs_to :department, optional: true

  delegate :program, to: :department, allow_nil: true
end
