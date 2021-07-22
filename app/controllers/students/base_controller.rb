# frozen_string_literal: true

module Students
  class BaseController < ApplicationController
    before_action { head :forbidden unless current_user.is_a?(Student) }
  end
end
