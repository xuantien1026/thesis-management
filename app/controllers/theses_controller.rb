# frozen_string_literal: true

class ThesesController < ApplicationController
  def index
    @theses = policy_scope(Thesis)
  end

  def show
    @thesis = Thesis.find(params[:id])
  end
end
