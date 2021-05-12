# frozen_string_literal: true

require 'csv'

module Admin
  class MidtermEvaluationsController < AdminController
    def index
      @faculty = Faculty.find(params[:faculty_id])
      respond_to do |format|
        format.xlsx
      end
    end
  end
end
