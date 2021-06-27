# frozen_string_literal: true

class ThesesController < ApplicationController
  def index
    @theses = policy_scope(Thesis).order(:ordering).load
    @midterm_evaluated = Theses::MidtermEvaluationSet.new(current_user, current_semester).evaluated?
  end

  def show
    @thesis = Thesis.find(params[:id])
  end
end
