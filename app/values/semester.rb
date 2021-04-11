# frozen_string_literal: true

class Semester
  def initialize(day = Time.zone.today, name: nil)
    @day = day
    @name = name || infer_semester_name
  end

  def to_s
    @name
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
