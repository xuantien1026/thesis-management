# frozen_string_literal: true

module DepartmentManagement
  class LecturersController < BaseController
    def index
      @lecturers = current_department.lecturers
    end

    def show
      @lecturer = Lecturer.find(params[:id])
    end
  end
end
