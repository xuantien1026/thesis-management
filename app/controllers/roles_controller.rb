# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :set_lecturer

  def show
    @role = @lecturer.roles.first&.name
  end

  def create
    authorize(Role)
    @lecturer.roles.destroy_all
    params[:roles].each { |role| @lecturer.add_role role }
    redirect_to lecturer_role_path(@lecturer), notice: 'Cập nhật thành công!'
  end

  private

  def set_lecturer
    @lecturer = Lecturer.find(params[:lecturer_id])
  end
end
