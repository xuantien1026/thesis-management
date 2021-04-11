# frozen_string_literal: true

require 'csv'

class LecturersImporter
  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    read_file(filepath)
      .map { |raw_data| process_data(raw_data) }
      .uniq { |lecturer_data| lecturer_data[:email] }
      .map { |lecturer_data| Lecturer.create!(lecturer_data) }
  end

  private

  def read_file(filepath)
    CSV.read(filepath).drop 1
  end

  def process_data(data)
    select_fields(data)
      .then { |data| strip_whitespace(data) }
      .then { |data| map_department_name_to_id(data) }
      .then { |data| build_lecturer(data) }
  end

  def select_fields(data)
    selected_data = data.filter.with_index { |_, i| [3, 4, 5, 6, 7].include?(i) }
    keys = %i[department mscb family_name first_name email]
    keys.zip(selected_data).to_h
  end

  def strip_whitespace(data)
    data.transform_values(&:strip)
  end

  def map_department_name_to_id(data) # rubocop:disable Metrics/MethodLength
    department_id =
      case data[:department]
      when 'HT&MMT'
        Department.find_by!(name: 'Department of System and Networking').id
      when 'CNPM'
        Department.find_by!(name: 'Department of Software Engineering').id
      when 'HTTT'
        Department.find_by!(name: 'Department of Information System').id
      when 'KHMT'
        Department.find_by!(name: 'Department of Computer Science').id
      when 'KTMT'
        Department.find_by!(name: 'Department of Computer Engineering').id
      else
        raise "Department #{value} not found"
      end
    data.merge(department_id: department_id).except!(:department)
  end

  def build_lecturer(data)
    name = "#{data[:family_name]} #{data[:first_name]}"
    data.merge(name: name, password: 'password').except!(:family_name, :first_name)
  end
end
