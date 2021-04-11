
class LecturerController < ApplicationController
  def index
    @lecturer = Lecturer.all
    @department = Department.all
  end
  def edit
    @lecturer = Lecturer.where("department_id = ?", 2)
    render  'lecturer_department'
  end
end
