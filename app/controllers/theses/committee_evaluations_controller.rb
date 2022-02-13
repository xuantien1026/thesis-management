# frozen_string_literal: true

module Theses
  class CommitteeEvaluationsController < LecturerController
    before_action :set_member, only: %i[new create]

    def show
      @evaluation = CommitteeEvaluation.find(params[:id])
      respond_to do |format|
        format.pdf do
          render pdf: 'phieu_danh_gia_lvtn_hd', margin: { top: 15, bottom: 15, left: 15, right: 15 },
                 show_as_html: params.key?('debug')
        end
      end
    end

    def new
      committee_member = @member.thesis.defense_committee.members.find_by(lecturer: current_user)
      @evaluation = CommitteeEvaluation.new(committee_member: committee_member, member: @member)
    end

    def create
      @evaluation = CommitteeEvaluation.new(evaluation_params)
      if @evaluation.save
        flash.notice = 'Đã lưu phiếu đánh giá LVTN'
        redirect_to @member.thesis.defense_committee
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_member
      @member = Member.find(params[:member_id])
    end

    def evaluation_params
      params.require(:theses_committee_evaluation).permit!
    end
  end
end
