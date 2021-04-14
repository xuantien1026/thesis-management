class FacultiesController < ApplicationController
  def index
    @faculties = Faculty.all
  end
end
