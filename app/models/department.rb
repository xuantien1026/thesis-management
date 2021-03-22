# frozen_string_literal: true

class Department < ApplicationRecord
  PROGRAMS = %w[CS CE].freeze

  belongs_to :head, class_name: 'User'
  has_many :lecturers, class_name: 'User', dependent: :restrict_with_error

  validates :program, inclusion: PROGRAMS
end
