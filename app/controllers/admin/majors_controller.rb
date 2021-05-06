# frozen_string_literal: true

module Admin
  class MajorsController < AdminController
    before_action :set_faculty, only: :index

    def index
      @majors = Major.where(faculty: @faculty)
    end

    private

    def set_faculty
      @faculty = Faculty.find(params[:faculty_id])
    end
  end
end
