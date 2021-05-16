# frozen_string_literal: true

class EducationProgram
  include ActiveModel::Validations
  PROGRAMS = %w[CQ CLC VLVH TC].freeze # Chinh quy, Chat luong cao, Vua lam vua hoc, Tai chuc
  attr_reader :education_program

  validates :education_program, inclusion: PROGRAMS

  def initialize(education_program)
    @education_program = education_program
  end

  def to_s
    education_program
  end

  def ==(other)
    education_program == other.education_program
  end
end
