# frozen_string_literal: true

module Admin
  class ThesesController < AdminController
    before_action :set_faculty
    def index
      @theses = Thesis.by_faculty(@faculty).order(:ordering)
    end

    def new; end

    def create; end

    private

    def set_faculty
      @faculty = Faculty.find(params[:faculty_id])
    end
  end
end
