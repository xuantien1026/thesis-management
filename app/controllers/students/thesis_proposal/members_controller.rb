# frozen_string_literal: true

module Students
  module ThesisProposal
    class MembersController < BaseController
      before_action :set_thesis_proposal

      def create
        result = ApplyTopic.call(student: current_user, topic: @thesis_proposal)
        if result.success?
          flash[:notice] = 'Đăng kí thành công'
        else
          flash[:alert] = result.errors
        end
        redirect_to students_thesis_proposal_path(@thesis_proposal)
      end

      def destroy
        ::ThesisProposals::Member.find(params[:id]).destroy
        redirect_back fallback_location: root_path, notice: 'Đã huỷ đăng kí ĐCLV'
      end

      private

      def set_thesis_proposal
        @thesis_proposal = ::ThesisProposal.find(params[:thesis_proposal_id])
      end
    end
  end
end
