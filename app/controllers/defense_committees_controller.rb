# frozen_string_literal: true

class DefenseCommitteesController < ApplicationController
  before_action :set_committee, except: :index
  before_action :set_committee_member, except: :index

  def index
    @committees = policy_scope(DefenseCommittee)
  end

  def show; end

  def start_session
    authorize @committee
    @committee.active!
    flash.notice = 'Đã bắt đầu phiên làm việc'
    redirect_to @committee
  end

  def end_session
    authorize @committee
    @committee.completed!
    flash.notice = 'Đã kết thúc phiên làm việc'
    redirect_to @committee
  end

  private

  def set_committee
    @committee = policy_scope(DefenseCommittee).find(params[:id])
  end

  def set_committee_member
    @committee_member = @committee.members.find_by(lecturer: current_user)
  end
end
