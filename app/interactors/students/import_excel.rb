# frozen_string_literal: true

module Students
  class ImportExcel
    include Interactor

    delegate :excel_file, :import_map, :faculty, to: :context

    def call
      # TODO: refactor this method
      read_first_worksheet
      row_index = import_map.header_rows
      ApplicationRecord.transaction do
        until @sheet[row_index].nil?
          unless faculty.majors.find_by(name: @sheet[row_index][import_map.major].value)
            context.errors ||= []
            context.errors << ("Không tìm thấy chuyên ngành \"#{@sheet[row_index][import_map.major].value}\" (dòng #{row_index + 1})")
            row_index += 1
            next
          end
          student = Student.new(student_attributes(@sheet[row_index]))
          if student.save
            # continue
          else
            context.errors ||= []
            context.errors << ("#{student.errors.full_messages.first} (dòng #{row_index + 1})")
          end
          row_index += 1
        end
        context.fail! if context.errors.present?
      end
    end

    private

    DEFAULT_PASSWORD = 'password'

    def student_attributes(row)
      { mssv: row[import_map.mssv]&.value,
        name: row[import_map.name]&.value,
        email: row[import_map.email]&.value,
        password: DEFAULT_PASSWORD,
        dkmh: row[import_map.dkmh]&.value,
        education_program: row[import_map.education_program]&.value,
        major: row[import_map.major]&.value,
      }
    end

    def read_first_worksheet
      workbook = RubyXL::Parser.parse(excel_file.path)
      @sheet = workbook[0]
    end
  end
end
