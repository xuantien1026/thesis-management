# frozen_string_literal: true

class Faculty < ApplicationRecord
  has_many :majors, dependent: :destroy
end
