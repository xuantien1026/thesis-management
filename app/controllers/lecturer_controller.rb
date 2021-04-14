
class LecturerController < ApplicationController
  def index
    @departments = Department.where("faculty_id = ?", params[:faculty_id])
    @lecturers = Lecturer.where("department_id = ?", @departments[0].id)
  end
  def department
    @lecturers = Lecturer.where("department_id = ?", params[:id])
    @departments = Department.all
    @department_id = params[:id]
    render  'lecturer_department'
  end
end
