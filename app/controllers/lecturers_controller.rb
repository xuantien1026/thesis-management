# frozen_string_literal: true

class LecturersController < ApplicationController
  before_action :set_department, only: :index

  def index
    @lecturers = Lecturer.where(department: @department)
  end

  def department
    @lecturers = Lecturer.where(department_id: params[:id])
    @departments = Department.all
    @department_id = params[:id]
    render 'lecturer_department'
  end

  private

  def set_department
    @department = Department.find(params[:department_id])
  end
end
