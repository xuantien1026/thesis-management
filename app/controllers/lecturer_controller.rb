
class LecturersController < ApplicationController
  def index
    @lecturers = Lecturer.where("department_id = ?", 1)
    @departments = Department.all
  end
  def department
    @lecturers = Lecturer.where("department_id = ?", params[:id])
    @departments = Department.all
    @department_id = params[:id]
    render  'lecturer_department'
  end
end
