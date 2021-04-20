# frozen_string_literal: true

class DefenseCommitteesController < ApplicationController
  before_action :set_theses, :set_lecturers, only: :new

  def index
    @committees = DefenseCommittee.all
  end

  def create
    @form = DefenseCommitteeForm.new(committee_params)
    if @form.save
      flash[:notice] = 'Đề xuất Hội Đồng Bảo Vệ thành công'
      redirect_to defense_committees_path
    else
      set_theses
      set_lecturers
      flash[:alert] = @form.errors.full_messages
      render :new
    end
  end

  def new
    @form = DefenseCommitteeForm.new
  end

  private

  def committee_params
    params.require(:defense_committee_form).permit(:chairman_id, :secretary_id, member_ids: [], thesis_ids: [])
  end

  def set_theses
    @theses = Thesis.by_department(current_user.department)
  end

  def set_lecturers
    @lecturers = current_user.department.lecturers
  end
end
