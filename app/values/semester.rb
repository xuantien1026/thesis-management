# frozen_string_literal: true

class Semester
  attr_reader :school_year, :semester_number

  def initialize(semester_number = nil, school_year = nil)
    @semester_number = semester_number
    @school_year = school_year

    set_default unless @semester_number && @school_year
  end

  def to_s
    "Học kì #{semester_number} (#{school_year}-#{school_year + 1})"
  end

  def ==(other)
    school_year == other.school_year && semester_number == other.semester_number
  end

  private

  def set_default
    @semester_number = 2
    @school_year = 2020
  end
end
