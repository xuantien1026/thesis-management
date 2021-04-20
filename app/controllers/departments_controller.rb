# frozen_string_literal: true

class DepartmentsController < ApplicationController
  before_action :set_faculty, only: :index

  def index
    @departments = Department.where(faculty: @faculty)
  end

  private

  def set_faculty
    @faculty = Faculty.find(params[:faculty_id])
  end
end
