# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action { head :forbidden unless current_user.has_any_role?(:admin, :super_admin) }
  end
end
