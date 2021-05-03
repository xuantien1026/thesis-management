# frozen_string_literal: true

class FacultiesController < ApplicationController
  def index
    @faculties = Faculty.all
  end

  def show
    @faculty = Faculty.find(params[:id])
    @departments = @faculty.departments
    @majors = @faculty.majors
  end
end
