# frozen_string_literal: true

module Lecturers
  class ImportExcel
    include Interactor

    delegate :excel_file, :import_map, to: :context

    def call
      # TODO: refactor this method
      read_first_worksheet
      @row_index = import_map.header_rows
      ApplicationRecord.transaction do
        until empty_row?
          unless Department.find_by(short_name: current_row[import_map.department]&.value)
            context.errors ||= []
            context.errors << ("Không tìm thấy bộ môn \"#{current_row[import_map.department]&.value}\" (dòng #{@row_index + 1})")
            @row_index += 1
            next
          end
          lecturer = Lecturer.new(lecturer_attributes.merge(password: DEFAULT_PASSWORD))
          if lecturer.save
            # continue
          else
            context.errors ||= []
            context.errors << ("#{lecturer.errors.full_messages.first} (dòng #{@row_index + 1})")
          end
          @row_index += 1
        end
        context.fail! if context.errors.present?
      end
    end

    private

    DEFAULT_PASSWORD = 'password'

    def empty_row?
      current_row.nil? || all_cells_empty?
    end

    def current_row
      @sheet[@row_index]
    end

    def all_cells_empty?
      lecturer_attributes.compact.blank?
    end

    def lecturer_attributes
      { mscb: current_row[import_map.mscb]&.value,
        name: current_row[import_map.name]&.value,
        email: current_row[import_map.email]&.value,
        department: Department.find_by(short_name: current_row[import_map.department]&.value) }
    end

    def read_first_worksheet
      workbook = RubyXL::Parser.parse(excel_file.path)
      @sheet = workbook[0]
    end
  end
end
