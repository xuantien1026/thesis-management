# frozen_string_literal: true

class MajorsController < ApplicationController
  before_action :set_faculty, only: :index

  def index
    @majors = Major.where(faculty: @faculty)
  end
  def destroy
    @major = Major.find(params[:id])
    @faculty_id = @major.faculty_id
    @major.destroy
    @majors = Major.where(faculty: @faculty_id)
    redirect_to faculty_majors_path(:faculty_id => @faculty_id), notice: "xoa thanh cong"
  end
  def create
    @major = Major.new
    @major.name = params[new_faculty_major_path][:name]
    @major.faculty_id = params[:faculty_id]
    @major.save
    @majors = Major.where(faculty: params[:faculty_id])
    render :majors
  end
  def edit
     @major = Major.find(params[:id])
  end
  def  update
    @major = Major.find(params[:id])
    @major.name = params[:major][:name]
    if @major.save
      render :major ,notice: "chỉnh sửa thành cng"
    else
      render :edit , notice: "chỉnh sửa không thành công"
    end
  end
  private
  def set_faculty
    @faculty = Faculty.find(params[:faculty_id])
  end
end
