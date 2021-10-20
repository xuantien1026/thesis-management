# frozen_string_literal: true

module Admin
  class StudentImportsController < AdminController
    def new
      @import_map = Students::ImportMap.new
    end

    def create
      @import_map = Students::ImportMap.new(import_map_params)
      context = Students::ImportExcel.call(excel_file: excel_file, import_map: @import_map, faculty: current_user.faculty)
      if context.success?
        flash.notice = 'Thành công!'
        redirect_to new_admin_student_import_path
      else
        flash.alert = context.errors
        render :new
      end
    end

    private

    def excel_file
      params[:excel_file]
    end

    def import_map_params
      params.require(:import_map).permit(:header_rows, :name, :email, :mssv, :dkmh, :education_program, :major)
    end
  end
end
