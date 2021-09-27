# frozen_string_literal: true

module Admin
  class FacultiesController < AdminController
    def index
      @faculties = Faculty.all.order(:id)
    end

    def show
      @faculty = Faculty.find(params[:id])
      @departments = @faculty.departments
      @majors = @faculty.majors
      @major_committees = @faculty.major_committees
    end
  end
end
