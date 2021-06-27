# frozen_string_literal: true

class ThesesController < ApplicationController
  def index
    @theses = policy_scope(Thesis).order(:ordering).load
    @midterm_evaluated = Theses::MidtermEvaluation.joins(:member).where(member: { thesis_id: @theses.ids }).any?
  end

  def show
    @thesis = Thesis.find(params[:id])
  end
end
