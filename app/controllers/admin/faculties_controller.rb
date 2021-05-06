# frozen_string_literal: true

module Admin
  class FacultiesController < AdminController
    def index
      @faculties = Faculty.all
    end

    def show
      @faculty = Faculty.find(params[:id])
      @departments = @faculty.departments
      @majors = @faculty.majors
    end
  end
end
