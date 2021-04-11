# frozen_string_literal: true

class EducationProgram
  include ActiveModel::Validations
  PROGRAMS = %w[CQ VLVH TC].freeze # Chinh Quy, Vua lam vua hoc, Tai Chuc
  attr_reader :name

  validates :name, inclusion: PROGRAMS

  def initialize(name)
    @name = name
  end
end
