# frozen_string_literal: true

class Semester
  attr_reader :semester

  def initialize(semester = nil, day = Time.zone.today)
    @day = day
    @semester = semester || infer_semester_name
  end

  def to_s
    semester
  end

  def ==(other)
    to_s == other.to_s
  end

  private

  def infer_semester_name
    "HK#{year_component}#{semester_number}"
  end

  def year_component
    return @day.year % 100 if @day >= start_hk1

    @day.year % 100 - 1
  end

  def semester_number
    return 2 if @day >= start_hk2 && @day < start_hk3
    return 3 if @day >= start_hk3 && @day < start_hk1

    1
  end

  def start_hk1
    @day.change(month: 9, day: 1)
  end

  def start_hk2
    @day.change(month: 3, day: 1)
  end

  def start_hk3
    @day.change(month: 7, day: 1)
  end
end
