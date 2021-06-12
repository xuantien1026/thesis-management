# frozen_string_literal: true

module Admin
  class DefenseCommitteesController < ApplicationController
    before_action :set_department

    def index
      @committees = DefenseCommittee.where(department: @department)
    end

    def create
      @form = DefenseCommitteeForm.new(committee_params)
      if @form.save
        flash[:notice] = 'Đề xuất Hội Đồng Bảo Vệ thành công'
        redirect_to defense_committees_path
      else
        flash[:alert] = @form.errors.full_messages
        render :new
      end
    end

    def new
      @thesis_groups = @department.lecturers.map { |lecturer| [lecturer, Thesis.by_lecturer(lecturer)] }.to_h
    end

    private

    def committee_params
      params.require(:defense_committee_form).permit(:chairman_id, :secretary_id, member_ids: [], thesis_ids: [])
    end

    def set_department
      @department = Department.find(params[:department_id])
    end
  end
end
