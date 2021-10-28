# frozen_string_literal: true

class ThesisProposalsController < ApplicationController
  before_action :set_thesis_proposal, except: %i[index new create]

  def index
    @thesis_proposals = ThesisProposal.by_lecturer(current_user).order(:id)
  end

  def show; end

  def new
    @thesis_proposal = ThesisProposal.new
    authorize @thesis_proposal
  end

  def edit
    authorize @thesis_proposal
  end

  def create
    authorize(ThesisProposal)
    @thesis_proposal = ThesisProposal.new(thesis_proposal_params)
    @thesis_proposal.advisors.build(lecturer: primary_advisor, primary: true)
    if @thesis_proposal.save
      flash[:notice] = 'Tạo đề cương luận văn thành công'
      redirect_to @thesis_proposal
    else
      render :new, status: :unprocessable_entity
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

  def major_committee_approve
    authorize @thesis_proposal
    @thesis_proposal.major_committee_approved!
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
      :semester_id, :major_id, :education_program, :title, :english_title, :description, :mission, :max_student_count,
      :reference
    )
  end

  def primary_advisor
    Lecturer.find(params[:primary_advisor_id])
  end
end
