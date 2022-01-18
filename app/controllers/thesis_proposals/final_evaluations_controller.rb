module ThesisProposals
  class FinalEvaluationsController < LecturerController
    before_action :set_final_evaluation_set, only: %i[new create]

    def new; end

    def create
      @final_evaluation_set.evaluations = evaluations_param
      if @final_evaluation_set.save
        redirect_to thesis_proposals_path, notice: 'Đã chấm điểm cuối kì ĐCLV'
      else
        render :new, alert: @final_evaluation_set.errors.full_messages.to_sentence
      end
    end

    private

    def set_final_evaluation_set
      @final_evaluation_set = FinalEvaluationSet.new(current_user, Current.semester)
    end

    def evaluations_param
      params.require(:thesis_proposals_final_evaluation_set)
            .require(:thesis_proposals_final_evaluation)
            .transform_keys(&:to_i)
            .transform_values { |p| p.permit(:result, :note) }
    end
  end
end