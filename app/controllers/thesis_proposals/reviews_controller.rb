# frozen_string_literal: true

module ThesisProposals
  class ReviewsController < ApplicationController
    def index
      @reviews = Review.includes(:thesis_proposal).where(lecturer: current_user)
    end
  end
end
