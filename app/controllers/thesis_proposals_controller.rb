# frozen_string_literal: true

class ThesisProposalsController < ApplicationController
  before_action :set_thesis_proposal, only: %i[show edit update destroy department_approve faculty_approve]

  def index
    @thesis_proposals = policy_scope(ThesisProposal).order(:id)
  end

  def show; end

  def new
    @thesis_proposal = ThesisProposal.new
    @majors = current_user.faculty.majors
    authorize @thesis_proposal
  end

  def edit
    authorize @thesis_proposal
    @majors = current_user.faculty.majors
  end

  def create # rubocop:disable Metrics/MethodLength
    context = CreateThesisProposal.call(thesis_proposal_params: thesis_proposal_params,
                                        primary_advisor: primary_advisor,
                                        students: students)
    if context.success?
      flash[:notice] = 'Tạo đề cương luận văn thành công'
      redirect_to context.thesis_proposal
    else
      @thesis_proposal = context.thesis_proposal
      @majors = current_user.faculty.majors
      render :new, alert: context.errors
    end
  end

  def update
    authorize @thesis_proposal
    if @thesis_proposal.update(thesis_proposal_params)
      redirect_to @thesis_proposal, notice: 'Cập nhật đề tài thành công'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @thesis_proposal
    @thesis_proposal.destroy
    redirect_to thesis_proposals_url, notice: 'Xoá đề tài thành công'
  end

  def department_approve
    authorize @thesis_proposal
    @thesis_proposal.department_approved!
    render 'approval'
  end

  def faculty_approve
    authorize @thesis_proposal
    @thesis_proposal.faculty_approved!
    render 'approval'
  end

  private

  def set_thesis_proposal
    @thesis_proposal = ThesisProposal.find(params[:id])
  end

  def thesis_proposal_params
    params.require(:thesis_proposal).permit(
      :semester, :title, :english_title, :description, :mission, :max_student_count, :education_program,
      references: [], majors: []
    )
  end

  def primary_advisor
    Lecturer.find(params[:primary_advisor_id])
  end

  def students
    Student.where(id: params[:student_ids])
  end
end
