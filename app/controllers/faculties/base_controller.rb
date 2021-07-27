# frozen_string_literal: true

module Faculties
  class BaseController < ApplicationController
    before_action { head :forbidden unless current_user.has_role? :head_of_faculty }

    private

    def current_faculty
      current_user.faculty
    end

    helper_method :current_faculty
  end
end
