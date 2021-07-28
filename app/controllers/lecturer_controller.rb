# frozen_string_literal: true

class LecturerController < ApplicationController
  before_action { head :forbidden unless current_user.is_a?(Lecturer) }
end
