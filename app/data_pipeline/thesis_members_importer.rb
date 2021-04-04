# frozen_string_literal: true

require 'csv'

class ThesisMembersImporter
  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    read_file(filepath)
      .keep_if { |data_row| data_row[5].present? }
      .map { |data_row| process_data(data_row) }
      .map { |member_data| create_member(member_data) }
  end

  private

  def read_file(filepath)
    CSV.read(filepath).drop 1
  end

  def process_data(data)
    select_fields(data)
      .then { |data| strip_whitespace(data) }
  end

  def select_fields(data)
    selected_data = data.filter.with_index { |_, i| [0, 3].include?(i) }
    keys = %i[mssv ordering]
    keys.zip(selected_data).to_h
  end

  def strip_whitespace(data)
    data.transform_values { |v| v&.strip }
  end

  def create_member(data)
    student = Student.find_by(mssv: data[:mssv])
    thesis = Thesis.find_by(ordering: data[:ordering])

    if student.nil? || thesis.nil?
      Rails.logger.warn "Could not import thesis member for #{data}"
      return
    end

    ThesisMember.create!(thesis: thesis, student: student)
  end
end
