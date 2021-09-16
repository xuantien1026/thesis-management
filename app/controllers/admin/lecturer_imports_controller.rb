# frozen_string_literal: true

module Admin
  class LecturerImportsController < AdminController
    HEADER_ROW_COUNT = 1
    DEFAULT_PASSWORD = 'password'

    def create
      import_lecturers
      redirect_to admin_imports_path, notice: 'Thành công!'
    end

    private

    def lecturer_excel_file
      params[:excel_file]
    end

    def import_lecturers # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      workbook = RubyXL::Parser.parse(lecturer_excel_file.path)
      sheet = workbook[0]
      row_index = HEADER_ROW_COUNT
      until sheet[row_index].nil?
        mscb = sheet[row_index][0].value
        name = sheet[row_index][1].value
        email = sheet[row_index][2].value
        department = sheet[row_index][3].value

        Lecturer.find_or_initialize_by(mscb: mscb).tap do |lecturer|
          lecturer.assign_attributes(
            name: name,
            email: email,
            password: DEFAULT_PASSWORD,
            department: Department.find_by!(short_name: department)
          )
          lecturer.save!
        end

        row_index += 1
      end
    end
  end
end
