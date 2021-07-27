# frozen_string_literal: true

module Admin
  class LecturersController < AdminController
    before_action :set_department, only: :index
    before_action :set_lecturer, only: :show

    def index
      @lecturers = Lecturer.where(department: @department)
    end

    def show
      @available_roles = current_user.has_role?(:super_admin) ? Role::ROLES : ['privileged_lecturer']
    end

    private

    def set_department
      @department = Department.find(params[:department_id])
    end

    def set_lecturer
      @lecturer = Lecturer.find(params[:id])
    end
  end
end
