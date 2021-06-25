module DepartmentManagement
  class BaseController < ApplicationController
    before_action :check_permission

    private

    def check_permission
      head :forbidden unless current_user.has_role? :head_of_department
    end

    def current_department
      current_user.department
    end

    helper_method :current_department
  end
end