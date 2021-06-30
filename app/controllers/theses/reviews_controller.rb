# frozen_string_literal: true

module Theses
  class ReviewsController < ApplicationController
    def index
      @reviews = Review.includes(:thesis).where(lecturer: current_user)
    end
  end
end
