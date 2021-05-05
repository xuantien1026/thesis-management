# frozen_string_literal: true

require 'csv'

class StudentsImporter
  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    read_file(filepath)
      .map { |data_row| process_data(data_row) }
      .map { |student_data| Student.create!(student_data.merge(dkmh: 'DCLV')) }
  end

  private

  def read_file(filepath)
    CSV.read(filepath).drop 1
  end

  def process_data(data)
    select_fields(data)
      .then { |data| strip_whitespace(data) }
      .then { |data| build_student(data) }
  end

  def select_fields(data)
    selected_data = data.filter.with_index { |_, i| [0, 1, 2].include?(i) }
    keys = %i[mssv family_name first_name]
    keys.zip(selected_data).to_h
  end

  def strip_whitespace(data)
    data.transform_values { |v| v&.strip }
  end

  def build_student(data)
    name = "#{data[:family_name]} #{data[:first_name]}"
    data.merge(name: name,
               password: 'password',
               email: "#{data[:mssv]}@hcmut.edu.vn",
               dkmh: 'DCLV',
               major: 'Computer Science',
               education_program: 'CQ')
        .except!(:family_name, :first_name)
  end
end
