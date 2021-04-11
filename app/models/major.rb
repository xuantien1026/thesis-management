# frozen_string_literal: true

class Major < ApplicationRecord
  belongs_to :faculty

  def to_s
    name
  end
end
