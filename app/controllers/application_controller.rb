# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: -> { head :forbidden }
end
