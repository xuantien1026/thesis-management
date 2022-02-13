# frozen_string_literal: true

module Students
  class ImportExcel
    include Interactor

    delegate :excel_file, :import_map, :faculty, to: :context

    def call
      # TODO: refactor this method
      read_first_worksheet
      @row_index = import_map.header_rows
      ApplicationRecord.transaction do
        until empty_row?
          unless faculty.majors.find_by(name: current_row[import_map.major].value)
            context.errors ||= []
            context.errors << ("Không tìm thấy chuyên ngành \"#{current_row[import_map.major].value}\" (dòng #{@row_index + 1})")
            @row_index += 1
            next
          end
          student = Student.new(student_attributes.merge(password: DEFAULT_PASSWORD))
          if student.save
            # continue
          else
            context.errors ||= []
            context.errors << ("#{student.errors.full_messages.first} (dòng #{@row_index + 1})")
          end
          @row_index += 1
        end
        context.fail! if context.errors.present?
      end
    end

    private

    DEFAULT_PASSWORD = 'password'

    def current_row
      @sheet[@row_index]
    end

    def empty_row?
      current_row.nil? || all_cells_empty?
    end

    def all_cells_empty?
      student_attributes.compact.blank?
    end

    def student_attributes
      { mssv: current_row[import_map.mssv]&.value,
        name: current_row[import_map.name]&.value,
        email: current_row[import_map.email]&.value,
        dkmh: current_row[import_map.dkmh]&.value,
        education_program: current_row[import_map.education_program]&.value,
        major: current_row[import_map.major]&.value }
    end

    def read_first_worksheet
      workbook = RubyXL::Parser.parse(excel_file.path)
      @sheet = workbook[0]
    end
  end
end
