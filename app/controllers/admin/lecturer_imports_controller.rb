# frozen_string_literal: true

module Admin
  class LecturerImportsController < AdminController
    def new
      @import_map = Lecturer::ImportMap.new
    end

    def create
      @import_map = Lecturer::ImportMap.new(import_map_params)
      context = Lecturer::ImportExcel.call(excel_file: excel_file, import_map: @import_map)
      if context.success?
        flash.notice = 'Thành công!'
        redirect_to new_admin_lecturer_import_path
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
      params.require(:import_map).permit(:header_rows, :mscb, :name, :email, :department)
    end
  end
end
