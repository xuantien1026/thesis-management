# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action { head :forbidden unless current_user.has_role? :admin }
  end
end
