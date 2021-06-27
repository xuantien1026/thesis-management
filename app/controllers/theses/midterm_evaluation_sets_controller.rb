# frozen_string_literal: true

module Theses
  class MidtermEvaluationSetsController < ApplicationController
    before_action :set_midterm_evaluation_set
    before_action { authorize @midterm_evaluation_set }

    def show
      respond_to do |format|
        format.pdf do
          render pdf: 'ket_qua_giua_ki', margin: { top: 20, bottom: 20, left: 20, right: 20 },
                 show_as_html: params.key?('debug')
        end
      end
    end

    def new
      @midterm_evaluation_set.members.each { |member| member.build_midterm_evaluation(passed: true) }
    end

    def create
      @midterm_evaluation_set.evaluations = evaluations_param
      if @midterm_evaluation_set.save
        flash.notice = 'Đã cập nhật kết quả giữa kì thành công'
        redirect_to theses_path
      else
        render :new, alert: @midterm_evaluation_set.errors.full_messages
      end
    end

    def edit; end

    def update
      @midterm_evaluation_set.evaluations = evaluations_param
      if @midterm_evaluation_set.save
        flash.notice = 'Đã cập nhật kết quả giữa kì thành công'
        redirect_to theses_path
      else
        render :new, alert: @midterm_evaluation_set.errors.full_messages
      end
    end

    private

    def evaluations_param
      params.require(:theses_midterm_evaluation_set)
            .require(:theses_midterm_evaluation)
            .transform_keys(&:to_i)
            .transform_values { |evaluation| evaluation.permit(:passed, :note) }
    end

    def set_midterm_evaluation_set
      @midterm_evaluation_set = MidtermEvaluationSet.new(current_user, current_semester)
    end
  end
end
