# frozen_string_literal: true

module Lecturer
  class ImportExcel
    include Interactor

    delegate :excel_file, :import_map, to: :context

    def call
      # TODO: refactor this method
      read_first_worksheet
      row_index = import_map.header_rows
      ApplicationRecord.transaction do
        until @sheet[row_index].nil?
          unless Department.find_by(short_name: @sheet[row_index][import_map.department].value)
            context.errors ||= []
            context.errors << ("Không tìm thấy bộ môn \"#{@sheet[row_index][import_map.department].value}\" (dòng #{row_index + 1})")
            row_index += 1
            next
          end
          lecturer = Lecturer.new(lecturer_attributes(@sheet[row_index]))
          if lecturer.save
            # continue
          else
            context.errors ||= []
            context.errors << ("#{lecturer.errors.full_messages.first} (dòng #{row_index + 1})")
          end
          row_index += 1
        end
        context.fail! if context.errors.present?
      end
    end

    private

    DEFAULT_PASSWORD = 'password'

    def lecturer_attributes(row)
      { mscb: row[import_map.mscb].value,
        name: row[import_map.name].value,
        email: row[import_map.email].value,
        password: DEFAULT_PASSWORD,
        department: Department.find_by(short_name: row[import_map.department].value) }
    end

    def read_first_worksheet
      workbook = RubyXL::Parser.parse(excel_file.path)
      @sheet = workbook[0]
    end
  end
end
