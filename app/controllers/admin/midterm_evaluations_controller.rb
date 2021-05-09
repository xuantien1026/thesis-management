# frozen_string_literal: true

require 'csv'

module Admin
  class MidtermEvaluationsController < AdminController
    def index
      @faculty = Faculty.find(params[:faculty_id])
      respond_to do |format|
        format.csv { send_data midterm_result, filename: 'KetQuaChamGiuaKiLVTN.csv' }
      end
    end

    private

    def midterm_result
      CSV.generate(encoding: Encoding::UTF_8) do |csv|
        csv << ['MSSV', 'Họ và tên', 'MĐT', 'Kết quả giữa kì']
        ThesisMember.includes(:student, :thesis, :midterm_evaluation).find_each do |member|
          csv << [member.mssv, member.name, member.thesis.ordering,
                  (if member.midterm_evaluation.present?
                     member.midterm_evaluation.passed? ? 'Đạt' : 'Không Đạt'
                   end)]
        end
      end
    end
  end
end
