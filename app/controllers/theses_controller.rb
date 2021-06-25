# frozen_string_literal: true

class ThesesController < ApplicationController
  def index
    @theses = policy_scope(Thesis).order(:ordering).load
    @midterm_evaluated = MidtermEvaluation.joins(:thesis_member).where(thesis_members: { thesis_id: @theses.ids }).any?
  end

  def show
    @thesis = Thesis.find(params[:id])
  end
end
