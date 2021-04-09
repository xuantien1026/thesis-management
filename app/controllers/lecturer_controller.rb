
class LecturerController < ApplicationController
  def index
    @lecturer = Lecturer.all
    @department = Department.all
  end
  def lecturerbydepartment
    @lecturerbyddepartment = Lecturer.where("department_id = ?", params[:department] )
    respond_to do |format|
      format.json  { render :json => @lecturerbyddepartment }
    end
  end
end
