# frozen_string_literal: true

module Admin
  class ThesisMembersController < AdminController
    before_action :set_thesis, only: %i[new create]

    def new
      @member = @thesis.members.build
    end

    def create
      @member = @thesis.members.build(member_params)
      @member.save
      flash.notice = 'Đăng kí sinh viên thành công'
      redirect_to @thesis
    end

    def destroy
      member = Theses::Member.find(params[:id])
      member.destroy
      flash.notice = 'Xoá sinh viên thành công'
      redirect_to member.thesis
    end

    private

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end

    def member_params
      params.require(:theses_member).permit(:thesis_id, :student_id)
    end
  end
end
