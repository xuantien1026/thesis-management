# frozen_string_literal: true

module Admin
  class RolesController < AdminController
    before_action :set_lecturer

    def show
      @role = @lecturer.roles.first&.name
    end

    def create
      @lecturer.roles.destroy_all
      role_params.each { |role| @lecturer.add_role role }
      redirect_to lecturer_role_path(@lecturer), notice: 'Cập nhật thành công!'
    end

    private

    def set_lecturer
      @lecturer = Lecturer.find(params[:lecturer_id])
    end

    def role_params
      params[:roles] || []
    end
  end
end
