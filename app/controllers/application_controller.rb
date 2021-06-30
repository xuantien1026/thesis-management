# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: -> { head :forbidden }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def current_semester
    Semester.last
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[email name type department_id])
  end

  def authenticate_inviter!
    authorize :invitation
    super
  end

  helper_method :current_semester
end
