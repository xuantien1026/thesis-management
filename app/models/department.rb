# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  program    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Department < ApplicationRecord
  PROGRAMS = %w[CS CE].freeze

  has_many :lecturers, dependent: :restrict_with_error

  validates :program, inclusion: PROGRAMS
end
