module ThesisProposals
  class ReviewerEvaluationsController < LecturerController
    before_action :set_thesis_proposal

    def new
      @reviewer_evaluation = @thesis_proposal.build_reviewer_evaluation
    end

    def create
      @reviewer_evaluation = @thesis_proposal.build_reviewer_evaluation(reviewer_evaluation_params)
      if @reviewer_evaluation.save
        flash.notice = 'Đã lưu phiếu nhận xét ĐCLV'
        redirect_to @thesis_proposal
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @reviewer_evaluation = @thesis_proposal.reviewer_evaluation
    end

    def update
      @reviewer_evaluation =  @thesis_proposal.reviewer_evaluation
      if @reviewer_evaluation.update(reviewer_evaluation_params)
        flash.notice = 'Đã chỉnh sửa phiếu nhận xét ĐCLV'
        redirect_to @thesis_proposal
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_thesis_proposal
      @thesis_proposal = ThesisProposal.find(params[:thesis_proposal_id])
    end

    def reviewer_evaluation_params
      params.require(:thesis_proposals_reviewer_evaluation)
            .permit(:a1, :a2, :b1, :b2, :c1, :c2, :d1, :d2, :e1, :e2)
            .merge(evaluation_date: Date.today)
    end
  end
end