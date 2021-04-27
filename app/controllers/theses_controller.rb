# frozen_string_literal: true

class ThesesController < ApplicationController
  def index
    @theses = policy_scope(Thesis).order(:ordering)
    @midterm_evalutated = @theses.first.midterm_evaluations.any?
  end

  def show
    @thesis = Thesis.find(params[:id])
  end
end
