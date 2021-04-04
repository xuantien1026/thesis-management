# frozen_string_literal: true

require 'csv'

class ThesesImporter
  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    read_file(filepath)
      .filter { |data_row| data_row[17] == 'LVTN' }
      .map { |data_row| process_data(data_row) }
      .map { |thesis_data| Thesis.create!(thesis_data) }
  end

  private

  def read_file(filepath)
    CSV.read(filepath).drop 1
  end

  def process_data(data)
    select_fields(data)
      .then { |data| strip_whitespace(data) }
      .then { |data| strip_titles(data) }
      .then { |data| find_primary_advisor(data) }
  end

  def select_fields(data)
    selected_data = data.filter.with_index { |_v, i| [0, 1, 2, 4].include?(i) }
    keys = %i[ordering title english_title mscb]
    keys.zip(selected_data).to_h
  end

  def strip_whitespace(data)
    data.transform_values { |v| v&.strip }
  end

  def strip_titles(data)
    data[:title] = nil unless data[:title].to_s.length > 4
    data[:english_title] = nil unless data[:english_title].to_s.length > 4
    data
  end

  def find_primary_advisor(data)
    primary_advisor_id = Lecturer.find_by!(mscb: data[:mscb]).id
    data.merge(primary_advisor_id: primary_advisor_id).except!(:mscb)
  end
end
