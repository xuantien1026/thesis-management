# frozen_string_literal: true

class ThesisProposalMembersController < ApplicationController
  before_action :set_thesis_proposal

  def create
    result = ApplyTopic.call(student: current_user, topic: @thesis_proposal)
    if result.success?
      flash[:notice] = 'Đăng kí thành công'
    else
      flash[:alert] = result.errors
    end
    redirect_to @thesis_proposal
  end

  private

  def set_thesis_proposal
    @thesis_proposal = ThesisProposal.find(params[:thesis_proposal_id])
  end
end
