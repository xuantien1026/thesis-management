# frozen_string_literal: true

module DepartmentManagement
  class ThesesController < BaseController
    def index
      @theses = Thesis.by_department(current_department).includes(:reviewer)
    end
  end
end
