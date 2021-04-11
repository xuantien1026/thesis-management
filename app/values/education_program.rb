# frozen_string_literal: true

class EducationProgram
  include ActiveModel::Validations
  PROGRAMS = %w[CQ VLVH TC].freeze # Chinh Quy, Vua lam vua hoc, Tai Chuc
  attr_reader :education_program

  validates :education_program, inclusion: PROGRAMS

  def initialize(education_program)
    @education_program = education_program
  end

  def to_s
    education_program
  end
end
