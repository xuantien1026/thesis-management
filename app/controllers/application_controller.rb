# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include SetCurrentRequestDetails

  rescue_from Pundit::NotAuthorizedError, with: -> { head :forbidden }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def current_semester
    Semester.order(:start_date).last
  end

  def current_major_committees
    MajorCommittee.joins(:members).where(members: { lecturer_id: current_user.id })
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[email name type department_id])
  end

  def authenticate_inviter!
    authorize :invitation
    super
  end

  helper_method :current_semester
  helper_method :current_major_committees
end
