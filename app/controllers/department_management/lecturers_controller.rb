# frozen_string_literal: true

module DepartmentManagement
  class LecturersController < BaseController
    def index
      @lecturers = current_department.lecturers
    end
  end
end
