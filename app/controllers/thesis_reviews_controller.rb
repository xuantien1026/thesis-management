# frozen_string_literal: true

class ThesisReviewsController < ApplicationController
  def index
    @thesis_reviews = ThesisReview.includes(:thesis).where(lecturer: current_user)
  end
end
