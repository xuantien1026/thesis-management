class SemestersController < ApplicationController
  def index
    @semesters = Semester.all
  end
end