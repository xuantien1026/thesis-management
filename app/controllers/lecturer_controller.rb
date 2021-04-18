
class LecturerController < ApplicationController
  def index
    @departments = Department.where("faculty_id = ?", params[:faculty_id])
    @departments_id = @departments.first ? @departments.first.id : -1
    @lecturers = Lecturer.where("department_id = ?", @departments_id)
  end
  def department
    @lecturers = Lecturer.where("department_id = ?", params[:id])
    @departments = Department.all
    @department_id = params[:id]
    render  'lecturer_department'
  end
end
